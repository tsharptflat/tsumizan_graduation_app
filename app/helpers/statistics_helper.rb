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

    RANK_CROWN_STYLES = {
        1 => { size: 28, color: '#e6c14d', gems: true },
        2 => { size: 22, color: '#c7ccd1', gems: false },
        3 => { size: 18, color: '#c98a4b', gems: false }
    }.freeze

    def rank_crown(rank)
        style = RANK_CROWN_STYLES[rank]
        return nil unless style

        content_tag :svg, viewBox: '0 0 24 24', width: style[:size], height: style[:size], fill: style[:color], class: 'rank-crown' do
            gems = style[:gems] ? tag.g(fill: '#fff') { tag.circle(cx: 4, cy: 9, r: 1.1) + tag.circle(cx: 12, cy: 6, r: 1.1) + tag.circle(cx: 20, cy: 9, r: 1.1) } : ''
            tag.path(d: 'M2 20h20l-2-11-5 4-3-7-3 7-5-4-2 11z') + gems
        end
    end
end