class GamesController < ApplicationController
    def  index
        @all_games_count = UserGameLibrary.all_games_count
        @all_unplayed_games_count = UserGameLibrary.all_unplayed_games_count


        @games = case params[:sort]
        when "name"
            Game.order(:game_title)
        when "price_asc"
            Game.order(price: :asc)
        when "price_desc"
            Game.order(price: :desc)
        when "possessed_count"
            Game.all.sort_by{ |game| -(@all_games_count.fetch(game.id, 0)) }
        when "unplayed_rate"
            Game.all.sort_by{ |game| -(@all_unplayed_games_count.fetch(game.id, 0).to_f / @all_games_count.fetch(game.id, 0).to_f) }
        else
            Game.all.sort_by{ |game| -(@all_games_count.fetch(game.id, 0)) }
        end
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
