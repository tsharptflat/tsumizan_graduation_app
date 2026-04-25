class AddPriceColumnsToCharacterTextConditions < ActiveRecord::Migration[7.2]
  def change
    add_column :character_text_conditions, :min_price, :integer
    add_column :character_text_conditions, :max_price, :integer
  end
end
