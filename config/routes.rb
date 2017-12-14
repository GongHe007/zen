Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index]
      resources :advertisements, only: [:index, :show, :create]
      resources :orders, only: [:create, :show] do
        collection do
          post :lock
        end
        member do
          post :buyer_checked, :seller_checked
        end
      end
    end
  end
end
