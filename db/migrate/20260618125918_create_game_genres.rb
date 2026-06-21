class CreateGameGenres < ActiveRecord::Migration[7.2]
  def change
    create_table :game_genres do |t|
      t.references :game, foreign_key: true
      t.references :game_genre_type, foreign_key: true
      t.timestamps
    end
  end
end
