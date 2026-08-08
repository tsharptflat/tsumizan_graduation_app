class UserStatisticSnapshot < ApplicationRecord
  belongs_to :user

  validates :recorded_on, uniqueness: { scope: :user_id }

  def self.record_for(user)
    find_or_create_by(user: user, recorded_on: Date.current) do |snapshot|
      snapshot.total_price = UserGameLibrary.total_price(user)
      snapshot.unplayed_rate = UserGameLibrary.unplayed_rate(user)
    end
  end
end
