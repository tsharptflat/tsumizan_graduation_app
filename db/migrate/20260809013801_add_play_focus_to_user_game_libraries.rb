class AddPlayFocusToUserGameLibraries < ActiveRecord::Migration[7.2]
  def change
    add_column :user_game_libraries, :play_focus, :integer, null: false, default: 0
  end
end
