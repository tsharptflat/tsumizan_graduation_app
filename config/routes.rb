Rails.application.routes.draw do
  get "omniauth_callbacks/steam"
  root "static_pages#top"

  resource :user, only: %i[show]

  get 'loading', to: 'users#loading'

  resource :statistic, only: %i[show]

  resource :user_session, only: %i[new create destroy]
end
