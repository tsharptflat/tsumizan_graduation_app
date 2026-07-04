class TaskCondition < ApplicationRecord
    belongs_to :task

    enum condition_type: {tsumige: 0, playtime: 1, trophies: 2, friendship_level: 3}

    def current_value(user)
      case condition_type
      when 'tsumige'
        UserGameLibrary.total_games_count(user)
      when 'playtime'
        UserGameLibrary.total_playtime_count(user)
      when 'friendship_level'
        user.user_characters.sum(:friendship_point)
      end
    end
end
