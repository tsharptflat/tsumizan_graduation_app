class StatisticsController < ApplicationController
  def show
    @user = current_user
    @total_price = UserGameLibrary.total_price(current_user)
    @unplayed_games = current_user.user_game_libraries.unplayed.includes(:game)# .limit(UserGameLibrary::TSUMIGE_LIST_LIMIT)
    @recommended_games = current_user.user_game_libraries.unplayed.cheapest_games.recommend_3
    @cleared_after_unplayed_games = current_user.user_game_libraries.cleared_after_unplayed.includes(:game)

    game_genres = UserGameLibrary.unplayed_game_genres(current_user)
    max_count = game_genres.map{ |x| x[1] }.max
    min_count = game_genres.map{ |x| x[1] }.min
    @most_unplayed_game_genres = game_genres.select{ |x| x[1] == max_count }
    @least_unplayed_game_genres = game_genres.select{ |x| x[1] == min_count }
  end

  def update_cleared_games
    @user_game_library = current_user.user_game_libraries

    if params[:cleared_game_ids].nil? #チェックなしの場合はreturnでメソッドを強制終了
      redirect_to statistic_path, alert: 'クリア済みゲームが選択されていません。'
      return
    end

    params[:cleared_game_ids].each do |id|
      @user_game_library.find(id).update!(cleared_date: Time.current)
    end

    redirect_to statistic_path, notice: 'クリア済みゲームを更新しました。'
  rescue #update!で例外エラーが発生したときの処理 beginが省略されている rescue単体にendは不要
    redirect_to statistic_path, alert: 'クリア済みゲームの更新に失敗しました。'
  end
end
