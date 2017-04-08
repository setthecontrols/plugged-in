Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :boardcategories, only: [:index] do
    resources :boardposts
  end
  root to: "home#index"
end
