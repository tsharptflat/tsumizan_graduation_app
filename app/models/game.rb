class Game < ApplicationRecord
  has_many :user_game_libraries, dependent: :destroy
  has_many :users, through: :user_game_libraries

  validates :game_title, presence: true
  validates :steam_app_id, presence: true, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  def self.find_or_create_by_steam_app_id(steam_app_id, game_title)
    game = Game.find_or_create_by(steam_app_id: steam_app_id) do |g|
      g.game_title = game_title
      g.price = 0 # デフォルト価格を0に設定
    end
    game
  end

  def self.update_price_from_steam_spy(steam_app_id)
    steam_spy_service = SteamSpyService.new
    game_info = steam_spy_service.get_game_info(steam_app_id)
    update(price: game_info['price'])
  end
end
