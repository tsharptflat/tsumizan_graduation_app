class BacklogsController < ApplicationController
  def show
    unplayed_games = current_user.user_game_libraries.unplayed.joins(:game).includes(:game)
    @unplayed_games = case params[:sort]
    when 'name'
      unplayed_games.order('games.game_title asc')
    when 'price_asc'
      unplayed_games.order('games.price asc')
    when 'price_desc'
      unplayed_games.order('games.price desc')
    else
      unplayed_games
    end
    @no_backlog = @unplayed_games.empty?
  end

  def update_cleared_game
    library = current_user.user_game_libraries.find(params[:library_id])
    library.update!(cleared_date: Time.current)
    Task.check_and_update_progress!(current_user)
    redirect_to backlog_path, notice: 'クリア済みにしました。'
  rescue
    redirect_to backlog_path, alert: '更新に失敗しました。'
  end

  def revert_cleared_game
    library = current_user.user_game_libraries.find(params[:library_id])
    library.update!(cleared_date: nil)
    redirect_to backlog_path, notice: '未クリアに戻しました。'
  rescue
    redirect_to backlog_path, alert: '更新に失敗しました。'
  end
end
