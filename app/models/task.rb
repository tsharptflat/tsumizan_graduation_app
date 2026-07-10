class Task < ApplicationRecord
    has_many :user_tasks
    has_many :users, through: :user_tasks
    has_many :task_rewards, dependent: :destroy
    has_one :task_condition, dependent: :destroy

    enum task_genre: {tsumige: 0, playtime: 1, trophies: 2, friendship_level: 3}

    def self.check_and_update_progress!(user)
      find_each do |task|
        user_task = user.user_tasks.find_or_create_by(task: task)
        next if user_task.completed_at.present?

        current_value = task.task_condition.current_value(user)
        user_task.current_value = current_value
        user_task.completed_at = Time.current if current_value >= task.task_condition.required_count
        user_task.save!
      end
    end
end
