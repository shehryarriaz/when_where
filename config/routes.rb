WhenWhere::Application.routes.draw do
  root to: 'users#index'
  devise_for :users
  resources :users
  resources :event_suggestions
end
