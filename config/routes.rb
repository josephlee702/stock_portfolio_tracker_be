Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      # Mount DeviseTokenAuth for user authentication
      mount_devise_token_auth_for 'User', at: 'auth'

      resources :users, only: [:index, :show]
      resources :portfolios, only: [:index, :show, :create, :update, :destroy] do
        resources :assets
        resources :transactions
      end
    end
  end
end
