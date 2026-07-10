class AddPointToTaskRewards < ActiveRecord::Migration[7.2]
  def change
    add_column :task_rewards, :point, :integer
  end
end
