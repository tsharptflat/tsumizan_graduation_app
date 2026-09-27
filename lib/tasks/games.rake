namespace :games do
  desc "DB内の全ゲームの価格をSteam Store APIから再取得する(通常は price.nil? の時しか叩かれないため、既存データを一括更新したい時に使う一回限りのタスク)"
  task refresh_prices: :environment do
    total = Game.count
    Game.find_each.with_index(1) do |game, i|
      prices = SteamApiService.new.get_game_price_and_genre(game.steam_app_id)
      if prices[:price]
        game.update!(price: prices[:price])
        puts "[#{i}/#{total}] #{game.game_title}: #{prices[:price]}円"
      else
        puts "[#{i}/#{total}] #{game.game_title}: 価格取得できず(スキップ)"
      end
      sleep 0.5 # 非公式APIへ連続で叩きすぎないよう間隔を空ける
    end
    puts '完了'
  end
end
