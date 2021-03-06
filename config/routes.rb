Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web, at: 'admin/sidekiq'
  namespace :api do
    namespace :v1 do
      get "market_price/coinmarket" => "market_price#coinmarket"

      resources :users, only: [:create] do
        collection do
          get :verify, :orders, :info, :advertisements
        end
      end
      resources :sessions, only: [:create]
      resources :advertisements, only: [:index, :show, :create]
      resources :orders, only: [:create, :show] do
        collection do
          post :lock
        end
        member do
          post :buyer_check, :seller_check, :close
        end
      end
    end
  end
end
