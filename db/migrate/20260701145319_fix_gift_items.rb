class FixGiftItems < ActiveRecord::Migration[7.2]
  def change
    remove_column :gift_items, :definition, :string
    add_column :gift_items, :description, :string
  end
end
