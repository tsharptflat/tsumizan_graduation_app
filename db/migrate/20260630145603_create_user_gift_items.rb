class CreateUserGiftItems < ActiveRecord::Migration[7.2]
  def change
    create_table :user_gift_items do |t|
      t.timestamps
      t.references :user
      t.references :gift_item
      t.integer :quantity
    end
  end
end
