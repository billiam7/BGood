Rails.application.routes.draw do
  root 'public_pages#home'
  get 'about_us' => 'dashboard#about_us'

  resources :b_good_users


  # resource :dashboard
  get 'dashboard' => 'dashboard#show'

  post 'searches/index', as: 'searches'
  get 'searches/index'

  get '/auth/oauth2/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'

  get '/logout' => 'logouts#logout'

  get '/challenges' => 'challenges#challenges', as: 'challenge'

  post '/b_good_user/join_organization' => 'b_good_usersr#join_organization', as: 'join_organization'

  get 'signup' => 'opportunities#signup'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
