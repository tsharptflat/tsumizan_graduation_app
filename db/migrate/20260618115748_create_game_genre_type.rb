class CreateGameGenreType < ActiveRecord::Migration[7.2]
  def change
    create_table :game_genre_types do |t|
      t.integer :genre_id
      t.string :name

      t.timestamps
    end
  end
end
