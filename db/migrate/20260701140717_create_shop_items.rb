class CreateShopItems < ActiveRecord::Migration[7.2]
  def change
    create_table :shop_items do |t|
      t.timestamps
      t.references :item, polymorphic: true
      t.integer :quantity
      t.float :price
    end
  end
end
