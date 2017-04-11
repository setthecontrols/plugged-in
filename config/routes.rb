Rails.application.routes.draw do
  devise_for :users
  resources :boardcategories, only: [:index] do
    resources :boardposts
  end

  resources :locations, except: [:update, :edit, :destroy]

  resources :searches, only: [:index]
  get 'searches/advanced', to: 'searches#advanced'
  get 'searches/advanced_form', to: 'searches#advanced_form'


  resources :useraudiofiles

  resources :users do
    resources :user_conversations, shallow: true
  end
  root to: "pages#home"

end
