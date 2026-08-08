class UpdateGamePriceJob < ApplicationJob
  queue_as :default

  def perform(user_id, steam_app_id)
    game = Game.find_by(steam_app_id: steam_app_id)
    return unless game

    prices = SteamApiService.new.get_game_price_and_genre(steam_app_id)

    user = User.find_by(id: user_id)

    if prices
      game.update(price: prices[:price] || 0, game_title: prices[:name].presence || game.game_title)
      unless UserGameLibrary.any_library_game_prices_nil?(user)
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
    else
      Turbo::StreamsChannel.broadcast_replace_to(
        user,
        target: "total_price",
        html: '<span id="total_price"><span class="fs-3">価格の取得に失敗しました。ページの再読み込みをしてください。</span></span>'
      )
    end
  end
end
