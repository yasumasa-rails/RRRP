Rails.application.routes.draw do
   devise_for :users
    root 'staffs#index'
    get 'api/staffs' => 'staffs#index'  ###パッチ
    scope :api, { format: 'json' } do
        resources :staffs do
          get :search , on: :collection
        end
    end 
  resources :staffs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # namespace :api do
  #  devise_for :users
  #  resources :recipes, :only=>[:index, :show]
  # end  
end
