class AddUnplayedDateToUserGameLibraries < ActiveRecord::Migration[7.2]
  def change
    add_column :user_game_libraries, :unplayed_date, :date
  end
end
