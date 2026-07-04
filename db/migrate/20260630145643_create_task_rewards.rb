class CreateTaskRewards < ActiveRecord::Migration[7.2]
  def change
    create_table :task_rewards do |t|
      t.references :task, foreign_key: true
      t.references :item, polymorphic: true
      t.integer :quantity
      t.timestamps
    end
  end
end
