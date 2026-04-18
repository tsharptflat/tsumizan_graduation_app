class SteamApiService
  include HTTParty
  base_uri 'https://store.steampowered.com/api'

  def get_game_price(app_id)
    response = self.class.get("appdetails", query: {
      appids: app_id,
      cc: 'jp',
      filters: 'price_overview'
    })

    data = response.parsed_response.dig(app_id.to_s, 'data', 'price_overview', 'final')
    return nil unless data

    data / 100.0
  end
end