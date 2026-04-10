Devise.setup do |config|
  config.omniauth :steam, ENV['STEAM_WEB_API_KEY']
end