class SteamApiService
  include HTTParty
  base_uri 'https://store.steampowered.com/api'

  def get_game_price_and_genre(steam_app_id)
    response = self.class.get("/appdetails", query: {
      appids: steam_app_id,
      cc: 'jp',
      l: 'japanese',
      filters: 'basic,price_overview,genres'
    })

    # レスポンスの最上位キーは、リクエストしたappidと一致しないことがある
    # (Steam側でそのゲームの正式なappidが後から変わった場合など)。
    # 1つのappidにつき1件しか返ってこないので、キーが何であれ最初の要素をそのまま使う。
    data = response.parsed_response.values.first&.dig('data')
    return {price: nil, genres: nil, name: nil} unless data.is_a?(Hash)
    # セール適用後の価格(final)ではなく、本来の資産価値を示すため定価(initial)を使う
    {price: data.dig('price_overview', 'initial')&./(100.0), genres: data.dig('genres'), name: data['name']}
  end
end
