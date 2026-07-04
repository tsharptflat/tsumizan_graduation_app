class CreateGiftItems < ActiveRecord::Migration[7.2]
  def change
    create_table :gift_items do |t|
      t.timestamps
      t.string :name
      t.string :definition
      t.integer :friendship_point, default: 0
      t.string :image_path
    end
  end
end
