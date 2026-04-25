class ChangeCharacterTextConditionsPageDataToString < ActiveRecord::Migration[7.2]
  def change
    change_column :character_text_conditions, :page, :string
  end
end
