class CreateUserWallets < ActiveRecord::Migration[7.2]
  def change
    create_table :user_wallets do |t|
      t.references :user, foreign_key: true
      t.integer :point, default: 0
      t.timestamps
    end
  end
end
