Rails.application.routes.draw do
  devise_for :users
  resources :articles
  resources :sources
  root to: 'articles#index'
end
