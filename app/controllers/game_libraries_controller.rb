class GameLibrariesController < ApplicationController
  def index
    steam_service = SteamService.new
    @user_game_libraries = steam_service.get_owned_games(current_user.uid)

    @user_game_libraries.each do |data|
      game = Game.find_or_create_by_steam_app_id(data['appid'], data['name'])
      current_user.user_game_libraries.create(game_id: game.id, minutes_played: data['playtime_forever'] || 0)

      library = current_user.user_game_libraries.find_or_initialize_by(game_id: game.id)
      library.minutes_played = data['playtime_forever'] || 0
      library.save!
    end
    @user_game_libraries = current_user.user_game_libraries.includes(:game)
  end
end
