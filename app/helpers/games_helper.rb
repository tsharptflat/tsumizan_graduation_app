module GamesHelper
  def steam_store_link(game)
    "https://store.steampowered.com/app/#{game.steam_app_id}"
  end

  def steam_banner_image(game)
    "https://cdn.akamai.steamstatic.com/steam/apps/#{game.steam_app_id}/header.jpg"
  end
end