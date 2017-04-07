Rails.application.routes.draw do
  devise_for :users
  resources :boardcategories, only: [:index] do
    resources :boardposts
  end
  root to: "home#index"
end
