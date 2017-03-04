Rails.application.routes.draw do
  root 'users#index'

  resource :users
  resources :controllers
  resources :dashboard



  get 'searches/index'

  get "/auth/oauth2/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
