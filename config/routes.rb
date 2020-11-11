Rails.application.routes.draw do
  resources :letters
  devise_for :users
  resources :sources
  resources :themes
  resources :countries, only: [:index, :show]
  resources :articles do
    collection do
      post :from_url
    end
  end
  root to: 'home#index'
end
