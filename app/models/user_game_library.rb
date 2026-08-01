class UserGameLibrary < ApplicationRecord
  UNPLAYED_THRESHOLD_MINUTES = 120
  CHEAPEST_GAMES_LIMIT = 10
  RECOMMENDATION_COUNT = 3
  TSUMIGE_LIST_LIMIT = 10
  COST_PERFORMANCE_RANKING_LIMIT = 3

  belongs_to :user
  belongs_to :game

  validates :game_id, uniqueness: { scope: :user_id }
  validates :minutes_played, numericality: { greater_than_or_equal_to: 0 }

  scope :not_recently_played, -> { where(last_played_at: nil).or(where('last_played_at < ?', 1.month.ago)) }
  scope :not_cleared, -> { where(cleared_date: nil)}
  scope :cleared, -> { where.not(cleared_date: nil)}
  scope :unplayed, -> { where('minutes_played <= ?', UNPLAYED_THRESHOLD_MINUTES).merge(not_recently_played).merge(not_cleared) }
  scope :cleared_after_unplayed, -> { where.not(unplayed_date: nil).merge(cleared)}

  scope :cheapest_games, -> { joins(:game).merge(Game.order(price: 'asc')).limit(CHEAPEST_GAMES_LIMIT) }

  def self.recommend_3
    all.to_a.sample(RECOMMENDATION_COUNT)
  end

  def self.sync_game_playtime_and_price(user, data)
    game = nil # トランザクションブロックの中から代入、ジョブにて被参照
    ActiveRecord::Base.transaction do
      game = Game.find_or_create_by_steam_app_id(data['appid'], data['name'])

      library = user.user_game_libraries.find_or_initialize_by(game_id: game.id)
      rtime = data['rtime_last_played']

      library.minutes_played = data['playtime_forever'] || 0
      library.last_played_at = rtime && rtime > 0 ? Time.at(rtime) : nil
      if library.unplayed_date.nil? && library.last_played_at.present? && library.minutes_played <= UNPLAYED_THRESHOLD_MINUTES && library.cleared_date.nil? && Time.current - library.last_played_at >= 1.month
        library.unplayed_date = library.last_played_at + 1.month
      end
      library.save!
    end
    UpdateGamePriceJob.perform_later(user.id, game.steam_app_id) if game.price.nil?
    UpdateGameGenreJob.perform_later(game.steam_app_id) if game.game_genres.empty?
  end

  def self.cost_performance_ranking(user)
    ranked = user.user_game_libraries.includes(:game).joins(:game).where.not(games: { price: nil }).where('games.price > 0').sort_by{ |library| -((library.minutes_played + 1).to_f / library.game.price)}
    {
      best: ranked.first(COST_PERFORMANCE_RANKING_LIMIT),
      worst: ranked.last(COST_PERFORMANCE_RANKING_LIMIT).reverse,
      all: ranked
    }
  end

  def self.total_price(user)
    user.user_game_libraries.unplayed.joins(:game).sum('games.price')
  end

  def self.total_games_count(user)
    user.user_game_libraries.unplayed.joins(:game).count
  end

  def self.unplayed_game_genres(user)
    libraries = user.user_game_libraries.unplayed.includes(game: :game_genre_types)
    genre_names = libraries.flat_map { |library| library.game.game_genre_types.map { |genre| genre.name } }
    genre_names.tally.sort_by{ |x| x[1] }
  end

  def self.cleared_game_count_rate(user)
    user.user_game_libraries.where.not(cleared_date: nil).count.to_f / user.user_game_libraries.count.to_f * 100
  end

  def self.cleared_games_count(user)
    user.user_game_libraries.cleared.count
  end

  def self.total_playtime_count(user)
    user.user_game_libraries.sum(:minutes_played)
  end

  def self.any_library_game_prices_nil?(user)
    user.user_game_libraries.unplayed.joins(:game).where(games: { price: nil }).exists?
  end
end