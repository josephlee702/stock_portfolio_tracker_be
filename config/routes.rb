Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show]

      mount_devise_token_auth_for 'User', at: "auth"

      post "login", to: "sessions#login"
      delete "logout", to: "sessions#destroy"

      #/api/v1/portfolios(/:id)
      resources :portfolios, only: [:index, :show, :create, :update, :destroy] do
        resources :assets
        resources :transactions
      end
    end
  end
end
