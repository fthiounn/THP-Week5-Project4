Rails.application.routes.draw do

  get 'likes/new'
  get 'likes/create'
  get 'likes/destroy'
  root 'gossips#index'

  # static pages controller
  get '/static_pages/contact', to: 'static_pages#contact'
  get '/static_pages/team', to: 'static_pages#team'

  resources :gossips do
    resources :comments do
      resources :likes
    end
    resources :likes
  end
  resources :users
  resources :cities
  resources :sessions, only: [:new, :create, :destroy]

  
end
