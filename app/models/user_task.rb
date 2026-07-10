class UserTask < ApplicationRecord
    belongs_to :user
    belongs_to :task

    scope :obtainable, -> { where.not(completed_at: nil).where(accepted_reward_at: nil)}
    scope :obtained, -> { where.not(completed_at: nil).where.not(accepted_reward_at: nil)}

    def self.obtain_all_rewards(user)
        user.user_tasks.obtainable.each do |user_task|
            user_task.task.task_rewards.each do |task_reward|
                task_reward.give_rewards(user)
            end
            user_task.accepted_reward_at = Time.current
            user_task.save!
        end
    end
end
