##https://qiita.com/DaichiSaito/items/b6239d70ab10b2070bc4
## https://qiita.com/jwako/items/d9f966a5edca1b07c393
Rails.application.routes.draw do
  ##mount_devise_token_auth_for 'User', at: 'auth', defaults: { format: "json" }
  devise_for :users
  namespace :api, defaults: { format: :json } do
    resources :menu, only: [:index]
  end

  
  get '/confirm_success' => 'home#confirm_success'
  get '/notes' => 'home#index'
  get '/notes/new' => 'home#index'
  get '/notes/:id/edit' => 'home#index'
  get '/notes/:id' => 'home#index'
  get '/signup' => 'home#index'
  post '/login' => 'home#index'
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
