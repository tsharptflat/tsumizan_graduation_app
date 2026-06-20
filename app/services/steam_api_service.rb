class SteamApiService
  include HTTParty
  base_uri 'https://store.steampowered.com/api'

  def get_game_price_and_genre(steam_app_id)
    response = self.class.get("/appdetails", query: {
      appids: steam_app_id,
      cc: 'jp',
      l: 'japanese',
      filters: 'price_overview,genres'
    })

    data = response.parsed_response.dig(steam_app_id.to_s, 'data')
    return nil unless data.is_a?(Hash)
    {price: data.dig('price_overview', 'final')&./(100.0), genres: data.dig('genres')}
  end
end
