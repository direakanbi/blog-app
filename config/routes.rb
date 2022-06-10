Rails.application.routes.draw do
  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create]
    resources :comments, only: [:create]
    resources :likes, only: [:create]
  end
end
