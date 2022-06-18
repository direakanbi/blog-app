Rails.application.routes.default_url_options[:host] = "XXX"
Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  root 'authors#index'

  resources :authors, only:[:index, :show] do
    resources :posts, only:[:index, :show] do
      resources :comments, only: [:create, :index, :new]
    end
  end

  resources :posts, only:[:create, :new, :edit, :destroy]
  resources :comments, only:[:edit, :destroy]
  post 'posts/:id/like', to: 'likes#index', as: 'like_action'

  # resources :posts, only:[:create, :new, :edit, :destroy]
  # resources :comments, only:[:edit, :destroy]
  # post 'posts/:id/like', to: 'likes#index', as: 'like_action'
end
