Rails.application.routes.draw do
  root 'dashboard#index'

  resource :users
  resources :controllers
  resources :dashboard
  post 'searches/index', as: 'searches'


  get 'searches/index'

  get "/auth/oauth2/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
