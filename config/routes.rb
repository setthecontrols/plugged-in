Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :boardcategories, only: [:index] do
    resources :boardposts
  end
  resources :searches, only: [:index]
  resources :sessions
  root to: "home#index"

  get 'auth/facebook/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
end
