module StatisticsHelper
    STEAM_GENRE_URL_SLUGS = {
        "アクション" => "Action",
        "アドベンチャー" => "Adventure",
        "ストラテジー" => "Strategy",
        "RPG" => "RPG",
        "インディー" => "Indie",
        "MM（Massively Multiplayer）" => "Massively Multiplayer",
        "カジュアル" => "Casual",
        "シミュレーション" => "Simulation",
        "レース" => "Racing",
        "スポーツ" => "Sports",
        "無料プレイ" => "Free to Play",
        "会計" => "Accounting",
        "オーディオ制作" => "Audio Production",
        "教育" => "Education",
        "写真編集" => "Photo Editing",
        "トレーニング" => "Software Training",
        "ユーティリティ" => "Utilities",
        "ビデオ制作" => "Video Production",
        "Webパブリッシング" => "Web Publishing",
        "早期アクセス" => "Early Access",
        "コントローラフレンドリー" => "Controller support"
    }.freeze

    def steam_genre_name_search(genre_name)
        "https://store.steampowered.com/genre/#{STEAM_GENRE_URL_SLUGS[genre_name]}"
    end
end