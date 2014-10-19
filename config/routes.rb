WhenWhere::Application.routes.draw do
  root to: 'event_suggestions#index'
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  resources :users
  resources :event_venues
  resources :event_suggestions do
    member do
      post :accept_suggestions
      put :finalise
    end
  end
end
