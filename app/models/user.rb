class User < ApplicationRecord
  has_many :user_characters, dependent: :destroy
  has_many :user_game_libraries, dependent: :destroy
  has_many :games, through: :user_game_libraries
  has_many :user_tasks, dependent: :destroy
  has_many :tasks, through: :user_tasks
  has_many :user_outfit_items, dependent: :destroy
  has_many :outfit_items, through: :user_outfit_items
  has_many :user_gift_items, dependent: :destroy
  has_many :gift_items, through: :user_gift_items
  has_one :user_wallet, dependent: :destroy

  validates :name, presence: true
  validates :uid, presence: true, uniqueness: true

  devise :omniauthable, omniauth_providers: [ :steam ]

  TOP_PAGE_USER_RANKINGS = 3

  def self.from_omniauth(auth)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user.name = auth.info.nickname
    user.save
    user
  end
end
