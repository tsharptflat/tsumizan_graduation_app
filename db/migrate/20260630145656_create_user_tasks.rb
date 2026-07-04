class CreateUserTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :user_tasks do |t|
      t.references :user, foreign_key: true
      t.references :task, foreign_key: true
      t.integer :current_value, default: 0
      t.datetime :completed_at
      t.datetime :accepted_reward_at
      t.timestamps
    end
  end
end
