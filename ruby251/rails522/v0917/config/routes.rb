Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  ###devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
   devise_for :users, path: :auth
   namespace :api, defaults: { format: :json }  do
    resources :screens, only: [:show, :update, :create, :destroy]
    resources :menu, only: [:index]
   end

    root 'home#index'
    get '/users/login' => 'home#index'
end
