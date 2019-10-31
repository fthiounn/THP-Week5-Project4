Rails.application.routes.draw do

 
  
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root 'gossips#index'

  # static pages controller
  get '/static_pages/contact', to: 'static_pages#contact'
  get '/static_pages/team', to: 'static_pages#team'

  resources :gossips do
    resources :comments
  end
  resources :users
  resources :cities
  resources :sessions, only: [:new, :create, :destroy]

  
end
