Rails.application.routes.draw do
  root 'public_pages/home'


  resource :users
  resources :challenges

  get 'dashboard' => 'dashboard#show'

  post 'searches/index', as: 'searches'


  get 'searches/index'

  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
