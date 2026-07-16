Rails.application.routes.draw do
  require "sidekiq/web" # require the web UI
  mount Sidekiq::Web => "/sidekiq" # access it at http://localhost:3000/sidekiq
  
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root "static_pages#top"

  resource :user, only: %i[show destroy]

  # devise_forで生成するルーティングのうち、DELETE /users/sign_outを上書きして、HTTP DELETEリクエストを受け取るようにする
  # （今回は:database_authenticatableが不要だが、ログアウトのルーティングが生成されていないため）
  devise_scope :user do
    delete 'users/sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end


  resources :user_game_libraries, only: %i[] do
    collection do
      get 'loading'
    end
  end

  resource :statistic, only: %i[show] do
    member do
      patch 'update_cleared_games'
    end
  end

  resources :tasks, only: %i[index show] do
    collection do
      patch 'obtain_all_rewards'
    end
  end

  resources :user_characters, only: %i[index show] do
    member do
      get 'communicate'
    end
    resources :gift_items, only: %i[index show] do
      collection do
        patch 'present_gift'
      end
    end
  end

  get '/terms', to: 'static_pages#terms'
  get '/privacy_policy', to: 'static_pages#privacy_policy'
end
