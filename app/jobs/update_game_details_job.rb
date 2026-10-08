# sidekiq-throttledはActiveJobに対応していないため、このジョブのみSidekiq::Jobで定義している
class UpdateGameDetailsJob
  include Sidekiq::Job
  include Sidekiq::Throttled::Job

  # 標準では失敗したゲームの価格取得が再試行が繰り返されて「計算中」のまま止まってしまうため、5回で打ち切る
  sidekiq_options queue: :default, retry: 5

  # 5回再試行後に失敗した場合、そのゲームを「取得失敗」として記録し、計算中の対象から外す
  # 残りのゲームが揃っていれば、取得できた分だけで総額を表示する
  sidekiq_retries_exhausted do |job, _exception|
    user_id, steam_app_id = job['args']
    Game.find_by(steam_app_id: steam_app_id)&.update(price_fetch_failed_at: Time.current)

    user = User.find_by(id: user_id)
    broadcast_total_price(user) if user && !UserGameLibrary.any_library_game_prices_pending?(user)
  end

  def self.broadcast_total_price(user)
    Turbo::StreamsChannel.broadcast_replace_to(
      user,
      target: "total_price",
      partial: "user_game_libraries/total_price",
      locals: { total_price: UserGameLibrary.total_price(user), user: user }
    )

    character_text = CharacterTextService.new.get_character_text(user.user_characters.first, 'users_show', UserGameLibrary.total_price(user))
    Turbo::StreamsChannel.broadcast_replace_to(
      user,
      target: "character_display",
      partial: "user_characters/character_display",
      locals: { character_text: character_text, character_expression: character_text.character_expression }
    )
  end

  # Steam Store APIは5分で約200回を超えると429が返るとされるため、余裕を持たせて2秒に1回までに制限する
  # 制限にかかったジョブはキューに戻され、枠が空き次第実行される
  sidekiq_throttle(
    threshold: { limit: 1, period: 2.seconds }
  )

  # 価格・タイトル・ジャンルは同じレスポンスに含まれるため、1度のAPI呼び出しでまとめて保存する
  def perform(user_id, steam_app_id)
    game = Game.find_by(steam_app_id: steam_app_id)
    return unless game

    # 429・5xx・タイムアウト等はここで例外が発生し、Sidekiqの再試行に乗る
    details = SteamApiService.new.get_game_price_and_genre(steam_app_id)

    update_genres(game, details[:genres])
    update_price(game, details, User.find_by(id: user_id))
  end

  private

  def update_genres(game, genres)
    # 同じゲームで複数回実行されても重複登録しないよう、未登録の場合のみ保存する
    return if genres.blank? || game.game_genres.exists?

    genres.each do |genre|
      game_genre_type = GameGenreType.find_or_create_by(genre_id: genre["id"], name: genre["description"])
      game.game_genres.create(game_genre_type_id: game_genre_type.id)
    end
  end

  def update_price(game, details, user)
    return unless game.price.nil?

    # 価格情報が無い場合(無料ゲーム、ストアから削除されたゲーム等)は0円として扱う。
    # 以前に取得失敗していたゲームが今回取得できた場合に備え、失敗記録も消す
    game.update(price: details[:price] || 0, game_title: details[:name].presence || game.game_title, price_fetch_failed_at: nil)
    return if user.nil? || UserGameLibrary.any_library_game_prices_pending?(user)

    self.class.broadcast_total_price(user)
  end
end
