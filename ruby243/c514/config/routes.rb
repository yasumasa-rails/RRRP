Rails.application.routes.draw do
    devise_for :users
    root 'vrorpmenus#index'
    #root 'staffs#index'
    #get 'api/staffs' => 'staffs#index'  ###パッチ
    #scope :api, { format: 'json' } do
    #    resources :staffs do
    #      get :search , on: :collection
    #    end
    #end 
  #resources :staffs
  resources :vrorpmenus
end
