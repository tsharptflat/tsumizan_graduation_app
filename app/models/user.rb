class User < ApplicationRecord
  has_many :user_characters, dependent: :destroy
  has_many :user_game_libraries, dependent: :destroy
  has_many :games, through: :user_game_libraries

  validates :name, presence: true
  validates :uid, presence: true, uniqueness: true

  devise :timeoutable, :omniauthable, omniauth_providers: [ :steam ]

  TOP_PAGE_USER_RANKINGS = 3

  def self.from_omniauth(auth)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user.name = auth.info.nickname
    user.save
    user
  end
end
