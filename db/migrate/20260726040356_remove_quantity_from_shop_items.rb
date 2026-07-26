class RemoveQuantityFromShopItems < ActiveRecord::Migration[7.2]
  def change
    remove_column :shop_items, :quantity, :integer
  end
end
