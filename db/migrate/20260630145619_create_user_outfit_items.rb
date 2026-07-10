class CreateUserOutfitItems < ActiveRecord::Migration[7.2]
  def change
    create_table :user_outfit_items do |t|
      t.timestamps
      t.references :user, foreign_key: true
      t.references :outfit_item, foreign_key: true
    end
  end
end
