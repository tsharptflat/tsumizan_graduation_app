class StatisticsController < ApplicationController
  CHART_RANGES = {
    'week' => 1.week,
    'month' => 1.month,
    'half_year' => 6.months,
    'year' => 1.year,
    'all' => nil
  }.freeze
  DEFAULT_CHART_RANGE = 'month'

  def show
    @user = current_user
    @total_price = UserGameLibrary.total_price(current_user)
    @unplayed_games = current_user.user_game_libraries.unplayed.includes(:game)# .limit(UserGameLibrary::TSUMIGE_LIST_LIMIT)
    @total_games_count = current_user.user_game_libraries.count
    @unplayed_rate = UserGameLibrary.unplayed_rate(current_user)
    @recommended_games = current_user.user_game_libraries.unplayed.cheapest_games.recommend_3
    @cleared_after_unplayed_games = current_user.user_game_libraries.cleared_after_unplayed.includes(:game)

    @cleared_game_count_rate = UserGameLibrary.cleared_game_count_rate(current_user)

    game_genres = UserGameLibrary.unplayed_game_genres(current_user)
    max_count = game_genres.map{ |x| x[1] }.max
    min_count = game_genres.map{ |x| x[1] }.min
    @most_unplayed_game_genres = game_genres.select{ |x| x[1] == max_count }
    @least_unplayed_game_genres = game_genres.select{ |x| x[1] == min_count }

    cost_performance_ranking = UserGameLibrary.cost_performance_ranking(current_user)
    @best_cost_performance_games = cost_performance_ranking[:best]
    @worst_cost_performance_games = cost_performance_ranking[:worst]

    @chart_range = CHART_RANGES.key?(params[:chart_range]) ? params[:chart_range] : DEFAULT_CHART_RANGE
    @user_statistic_snapshots = current_user.user_statistic_snapshots.order(:recorded_on)
    duration = CHART_RANGES[@chart_range]
    @user_statistic_snapshots = @user_statistic_snapshots.where(recorded_on: duration.ago..) if duration
  end

  def cost_performance_detailed_ranking
    cost_performance_ranking = UserGameLibrary.cost_performance_ranking(current_user)
    @all_cost_performance_games = cost_performance_ranking[:all]
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

    Task.check_and_update_progress!(current_user)

    redirect_to statistic_path, notice: 'クリア済みゲームを更新しました。'

  rescue #update!で例外エラーが発生したときの処理 beginが省略されている rescue単体にendは不要
    redirect_to statistic_path, alert: 'クリア済みゲームの更新に失敗しました。'
  end
end
