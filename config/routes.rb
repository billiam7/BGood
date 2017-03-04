Rails.application.routes.draw do
  root 'users#index'

  get "/auth/oauth2/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resource :users
  resources :controllers
end
