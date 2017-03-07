Rails.application.routes.draw do
  root 'public_pages#home'


  resources :b_good_users
  resources :challenges

  # resource :dashboard
  get 'dashboard' => 'dashboard#show'

  post 'searches/index', as: 'searches'


  get 'searches/index'

  get '/auth/oauth2/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'

  get '/logout' => 'logouts#logout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
