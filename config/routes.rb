WhenWhere::Application.routes.draw do
  get "event_choices/new"

  get "event_choices/create"

  root to: 'event_suggestions#index'
  devise_for :users
  resources :users
  resources :event_suggestions
end
