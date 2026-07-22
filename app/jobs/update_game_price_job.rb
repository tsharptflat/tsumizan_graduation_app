class UpdateGamePriceJob < ApplicationJob
  queue_as :default

  def perform(steam_app_id)
    game = Game.find_by(steam_app_id: steam_app_id)
    return unless game

    prices = SteamApiService.new.get_game_price_and_genre(steam_app_id)
    return unless prices

    game.update(price: prices[:price])
  end
end
