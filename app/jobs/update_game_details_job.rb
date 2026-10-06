class UpdateGameDetailsJob < ApplicationJob
  queue_as :default

  # 価格・タイトル・ジャンルは同じ/appdetailsのレスポンスに含まれるため、
  # 1回のAPI呼び出しでまとめて保存する(非公式APIへのリクエスト数を抑えるため)
  def perform(user_id, steam_app_id)
    game = Game.find_by(steam_app_id: steam_app_id)
    return unless game

    details = SteamApiService.new.get_game_price_and_genre(steam_app_id)

    user = User.find_by(id: user_id)

    if details
      update_genres(game, details[:genres])
      update_price(game, details, user)
    else
      Turbo::StreamsChannel.broadcast_replace_to(
        user,
        target: "total_price",
        html: '<span id="total_price"><span class="fs-3">価格の取得に失敗しました。ページの再読み込みをしてください。</span></span>'
      )
    end
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

    game.update(price: details[:price] || 0, game_title: details[:name].presence || game.game_title)
    return if user.nil? || UserGameLibrary.any_library_game_prices_nil?(user)

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
end
