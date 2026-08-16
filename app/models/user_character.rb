class UserCharacter < ApplicationRecord
  belongs_to :user
  belongs_to :character_type
  belongs_to :outfit_item, optional: true

  validates :name, presence: true
  validates :friendship_point, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  FRIENDSHIP_LEVEL_THRESHOLDS = { 1 => 0, 2 => 50, 3 => 170, 4 => 290, 5 => 490 }.freeze
  MAX_FRIENDSHIP_LEVEL = FRIENDSHIP_LEVEL_THRESHOLDS.keys.max

  def self.find_or_create_default_character(user)
    find_or_create_by!(user_id: user.id, character_type_id: CharacterType.find_by(name: 'いらすと子').id) do |uc|
      uc.name = 'サポートちゃん'
    end
  end

  def current_friendship_level
    FRIENDSHIP_LEVEL_THRESHOLDS.select {|level, required_point| required_point <= friendship_point }.keys.max
  end

  def max_friendship_level?
    current_friendship_level == MAX_FRIENDSHIP_LEVEL
  end

  def friendship_point_within_current_level
    friendship_point - FRIENDSHIP_LEVEL_THRESHOLDS[current_friendship_level]
  end

  def friendship_point_required_for_current_level
    return nil if max_friendship_level?

    FRIENDSHIP_LEVEL_THRESHOLDS[current_friendship_level + 1] - FRIENDSHIP_LEVEL_THRESHOLDS[current_friendship_level]
  end

  def friendship_point_progress_percent
    return 100 if max_friendship_level?

    [(friendship_point_within_current_level.to_f / friendship_point_required_for_current_level * 100), 100].min
  end
end
