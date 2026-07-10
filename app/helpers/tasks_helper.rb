module TasksHelper
  def task_row_class(user_task)
    return 'task-row-pending' if user_task.nil? || user_task.completed_at.blank?
    return 'task-row-claimed' if user_task.accepted_reward_at.present?

    'task-row-claimable'
  end
end
