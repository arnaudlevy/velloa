Rails.application.routes.draw do
  devise_for :users
  resources :articles do
    collection do
      post :from_url
    end
  end
  resources :sources
  root to: 'articles#index'
end
