Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  resources :articles do
    member do
      post 'create_summary'
    end
  end
  resources :objectives, only: [:index,:create, :update, :destroy]
  resources :tasks, only: [:create, :update, :destroy]
end
