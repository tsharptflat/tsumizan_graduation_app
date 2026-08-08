class CreateUserStatisticSnapshots < ActiveRecord::Migration[7.2]
  def change
    create_table :user_statistic_snapshots do |t|
      t.references :user, null: false, foreign_key: true
      t.date :recorded_on, null: false
      t.integer :total_price
      t.decimal :unplayed_rate

      t.timestamps
    end

    add_index :user_statistic_snapshots, [:user_id, :recorded_on], unique: true
  end
end
