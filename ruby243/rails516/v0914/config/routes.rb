Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  ##devise_for :users
  root 'screens#index'
  resource :screens
  match 'screens/index', to: 'screens#index', via: [:get]
  match 'screens/show', to: 'screens#show', via: [:get]
  match 'screens/pagination', to: 'screens#pagination', via: [:get]
  match 'screens/showfields', to: 'screens#showfields', via: [:get]
end
