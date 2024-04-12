Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  resources :articles
  resources :objectives, only: [:index,:create, :update, :destroy]
  resources :tasks, only: [:create, :update, :destroy]
end
