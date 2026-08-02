class GamesController < ApplicationController
    def  index

    end

    def show
        @user = current_user
        @game = Game.find(params[:id])
        @possessed_user_count = UserGameLibrary.game_statistics_count(@game)
        @unplayed_percentage = UserGameLibrary.game_statistics_unplayed_percentage(@game)
        @cleared_percentage = UserGameLibrary.game_statistics_cleared_rate(@game)
        @average_playtime = UserGameLibrary.game_statistics_average_playtime(@game)
        @average_unplayed_time = UserGameLibrary.game_statistics_average_unplayed_time(@game)

        @current_user_game = @user.user_game_libraries.find_by(game_id: @game.id)
    end
end
