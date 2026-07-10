class AddNecessaryColumnsToTaskConditions < ActiveRecord::Migration[7.2]
  def change
    add_column :task_conditions, :condition_type, :integer
    add_column :task_conditions, :required_count, :integer
  end
end
