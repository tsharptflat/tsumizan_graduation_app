class CreateTaskConditions < ActiveRecord::Migration[7.2]
  def change
    create_table :task_conditions do |t|
      t.references :task, foreign_key: true
      t.timestamps
    end
  end
end
