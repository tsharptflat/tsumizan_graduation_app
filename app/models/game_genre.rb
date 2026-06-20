class GameGenre < ApplicationRecord
  belongs_to :game
  belongs_to :game_genre_type
end
