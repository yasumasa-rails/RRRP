Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  ##devise_for :users
  root 'screens#index'
  get 'screens/index', :as => 'screens_index'
  resource :screens
  match 'screens/pagination', to: 'screens#pagination', via: [:get]
  match 'screens/showfields', to: 'screens#showfields', via: [:get]
end
