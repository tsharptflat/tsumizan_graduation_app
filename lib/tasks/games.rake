namespace :games do
  desc "DB内の全ゲームのタイトルをSteam Store APIの日本語名で更新する(日本語名の取得を入れる前に英語名で登録されたゲーム向けの一回限りのタスク)"
  task refresh_titles: :environment do
    total = Game.count
    updated = 0
    Game.find_each.with_index(1) do |game, i|
      begin
        name = SteamApiService.new.get_game_price_and_genre(game.steam_app_id)[:name]
        if name.present? && name != game.game_title
          puts "[#{i}/#{total}] #{game.game_title} -> #{name}"
          game.update!(game_title: name)
          updated += 1
        else
          puts "[#{i}/#{total}] #{game.game_title}: 変更なし"
        end
      rescue SteamApiService::RequestError, Net::OpenTimeout, Net::ReadTimeout => e
        puts "[#{i}/#{total}] #{game.game_title}: 取得できず(スキップ) #{e.message}"
      end
      # UpdateGameDetailsJobのレート制限(アプリ全体で2秒に1回)と同じペースで呼び出す
      sleep 2
    end
    puts "完了: #{updated}件を更新"
  end
end
