Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/auth/registrations',
        sessions: 'api/auth/sessions'
    }
    ##resources :screens
    ##resources :menus
  end
  namespace :api do
    resources :menus 
    resources :uploads 
    resources :tblfields  if Rails.env == "development" ##テスト環境の時のみ
  end  
  post '/rails/active_storage/direct_uploads' => 'active_storage/direct_uploads#create'
  ##post "/rails/active_storage/direct_uploads" => "active_storage/direct_uploads#create", as: :rails_direct_uploads
end
