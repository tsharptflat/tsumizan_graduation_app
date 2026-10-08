class AddPriceFetchFailedAtToGames < ActiveRecord::Migration[7.2]
  def change
    add_column :games, :price_fetch_failed_at, :datetime
  end
end
