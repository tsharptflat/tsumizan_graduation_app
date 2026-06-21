class UpdateGameGenreJob < ApplicationJob
  queue_as :default

  def perform(steam_app_id)
    game = Game.find_by(steam_app_id: steam_app_id)
    return unless game

    genres = SteamApiService.new.get_game_price_and_genre(steam_app_id)
    return unless genres
    genres[:genres].each do |genre|
        game_genre_type = GameGenreType.find_or_create_by(genre_id: genre["id"], name: genre["description"])
        game_genre = game.game_genres.create(game_genre_type_id: game_genre_type.id)
    end
  end
end
