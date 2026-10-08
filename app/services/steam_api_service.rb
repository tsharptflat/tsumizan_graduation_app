class SteamApiService
  include HTTParty
  base_uri 'https://store.steampowered.com/api'
  # 応答が無い場合に標準の60秒まで待ち続けてSidekiqの作業枠を塞がないよう、10秒で打ち切る
  default_timeout 10

  # 429(リクエスト過多)や5xx(Steam側の一時的な障害)など、時間をおけば成功し得る失敗。
  # ジョブ側でこのエラーを受けてSidekiqの再試行に乗せる
  class RequestError < StandardError; end

  def get_game_price_and_genre(steam_app_id)
    response = self.class.get("/appdetails", query: {
      appids: steam_app_id,
      cc: 'jp',
      l: 'japanese',
      filters: 'basic,price_overview,genres'
    })
    # エラーの中でもどのエラーかを明確にするため
    raise RequestError, "Steam Store API returned #{response.code} (appid: #{steam_app_id})" unless response.success?

    # レスポンスの最上位キーは、リクエストしたappidと一致しないことがある
    # (Steam側でそのゲームの正式なappidが後から変わった場合など)。
    # 1つのappidにつき1件しか返ってこないので、キーが何であれ最初の要素をそのまま使う。
    parsed = response.parsed_response
    data = parsed.is_a?(Hash) ? parsed.values.first&.dig('data') : nil
    # success: false(ストアから削除されたゲーム等)の場合。通信自体は成功しているため再試行はしない
    return {price: nil, genres: nil, name: nil} unless data.is_a?(Hash)
    # セール適用後の価格(final)ではなく、本来の資産価値を示すため定価(initial)を使う
    {price: data.dig('price_overview', 'initial')&./(100.0), genres: data.dig('genres'), name: data['name']}
  end
end
