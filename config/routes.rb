Rails.application.routes.draw do
  devise_for :users
  resources :sources
  resources :themes
  resources :articles do
    collection do
      post :from_url
    end
  end
  root to: 'articles#index'
end
