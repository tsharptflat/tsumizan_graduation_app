module GamesHelper
  def steam_store_link(game)
    "https://store.steampowered.com/app/#{game.steam_app_id}"
  end

  def steam_banner_image(game)
    "https://cdn.akamai.steamstatic.com/steam/apps/#{game.steam_app_id}/header.jpg"
  end

  def steam_thumbnail_image(game)
    "https://cdn.akamai.steamstatic.com/steam/apps/#{game.steam_app_id}/capsule_184x69.jpg"
  end

  def broken_thumbnail_placeholder
    svg = <<~SVG
      <svg xmlns="http://www.w3.org/2000/svg" width="184" height="69" viewBox="0 0 184 69">
        <rect width="184" height="69" fill="#f5f5f5"/>
        <text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle" font-size="11" fill="#666666">画像が見つかりませんでした</text>
      </svg>
    SVG
    "data:image/svg+xml;base64,#{Base64.strict_encode64(svg)}"
  end
end