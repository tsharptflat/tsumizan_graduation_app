class UserCharacter < ApplicationRecord
  belongs_to :user
  belongs_to :character_type
  belongs_to :outfit_item, optional: true

  validates :name, presence: true
  validates :friendship_point, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  FRIENDSHIP_LEVEL_THRESHOLDS = { 1 => 0, 2 => 50, 3 => 100 }.freeze

  def self.find_or_create_default_character(user)
    find_or_create_by!(user_id: user.id, character_type_id: CharacterType.find_by(name: 'いらすと子').id) do |uc|
      uc.name = '仮'
    end
  end

  def current_friendship_level
    FRIENDSHIP_LEVEL_THRESHOLDS.select {|level, required_point| required_point <= friendship_point }.keys.max
  end
end
