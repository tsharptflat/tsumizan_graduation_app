class StatisticsController < ApplicationController
  CHART_RANGES = %w[week month half_year year all].freeze
  DEFAULT_CHART_RANGE = 'month'
  CHART_RANGE_OFFSET_OPTIONS_COUNT = 12

  def show
    @user = current_user
    @total_price = UserGameLibrary.total_price(current_user)
    @unplayed_games = current_user.user_game_libraries.unplayed.includes(:game)
    @no_backlog = @unplayed_games.empty?
    @tsumige_list = @unplayed_games.joins(:game).order('games.price DESC').limit(3)
    @total_games_count = current_user.user_game_libraries.count
    @unplayed_rate = UserGameLibrary.unplayed_rate(current_user)
    @recommended_games = current_user.user_game_libraries.unplayed.cheapest_games.recommend_3
    @next_up_library = current_user.user_game_libraries.next_up.first

    @cleared_game_count_rate = UserGameLibrary.cleared_game_count_rate(current_user)

    game_genres = UserGameLibrary.unplayed_game_genres(current_user)
    max_count = game_genres.map { |x| x[1] }.max
    min_count = game_genres.map { |x| x[1] }.min
    @most_unplayed_game_genres = game_genres.select { |x| x[1] == max_count }
    @least_unplayed_game_genres = game_genres.select { |x| x[1] == min_count }
    @genre_example_games = (@most_unplayed_game_genres + @least_unplayed_game_genres).each_with_object({}) do |(genre_name, _count), hash|
      hash[genre_name] = current_user.user_game_libraries.unplayed.joins(game: :game_genre_types).find_by(game_genre_types: { name: genre_name })&.game
    end

    @best_cost_performance_games = UserGameLibrary.cost_performance_ranking(current_user)[:best]

    @chart_range = CHART_RANGES.include?(params[:chart_range]) ? params[:chart_range] : DEFAULT_CHART_RANGE
    @chart_range_offset = @chart_range == 'all' ? 0 : params[:chart_range_offset].to_i.clamp(0, CHART_RANGE_OFFSET_OPTIONS_COUNT - 1)
    @chart_range_options = chart_range_offset_options(@chart_range)

    @user_statistic_snapshots = current_user.user_statistic_snapshots.order(:recorded_on)
    start_date, end_date = chart_range_period(@chart_range, @chart_range_offset)
    @user_statistic_snapshots = @user_statistic_snapshots.where(recorded_on: start_date..end_date) if start_date
    @chart_labels, @chart_prices, @chart_rates = chart_series(@user_statistic_snapshots, start_date, end_date)
  end

  def cost_performance_detailed_ranking
    ranked_games = UserGameLibrary.cost_performance_ranking(current_user)[:all]
    @max_cost_performance_score = ranked_games.first&.cost_performance_score || 0
    @all_cost_performance_games = Kaminari.paginate_array(ranked_games).page(params[:page])
  end

  private

  def chart_series(snapshots, start_date, end_date)
    return [snapshots.pluck(:recorded_on), snapshots.pluck(:total_price), snapshots.pluck(:unplayed_rate)] unless start_date

    snapshots_by_date = snapshots.index_by(&:recorded_on)
    dates = (start_date..end_date).to_a
    prices = dates.map { |date| snapshots_by_date[date]&.total_price }
    rates = dates.map { |date| snapshots_by_date[date]&.unplayed_rate }
    [dates, prices, rates]
  end

  def chart_range_period(range, offset)
    today = Date.current
    case range
    when 'week'
      start_date = today.beginning_of_week - offset.weeks
      [start_date, start_date.end_of_week]
    when 'month'
      start_date = today.beginning_of_month - offset.months
      [start_date, start_date.end_of_month]
    when 'half_year'
      current_half_start = today.month <= 6 ? today.beginning_of_year : today.beginning_of_year + 6.months
      start_date = current_half_start - (offset * 6).months
      [start_date, start_date + 6.months - 1.day]
    when 'year'
      start_date = today.beginning_of_year - offset.years
      [start_date, start_date.end_of_year]
    else
      [nil, nil]
    end
  end

  def chart_range_offset_options(range)
    return [] if range == 'all'

    (0...CHART_RANGE_OFFSET_OPTIONS_COUNT).map do |offset|
      start_date, end_date = chart_range_period(range, offset)
      [chart_range_period_label(range, start_date, end_date), offset]
    end
  end

  def chart_range_period_label(range, start_date, end_date)
    case range
    when 'week'
      "#{start_date.strftime('%-m/%-d')}〜#{end_date.strftime('%-m/%-d')}"
    when 'month'
      "#{start_date.year}年#{start_date.month}月"
    when 'half_year'
      "#{start_date.year}年#{start_date.month <= 6 ? '上半期' : '下半期'}"
    when 'year'
      "#{start_date.year}年"
    end
  end
end
