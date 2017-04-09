Rails.application.routes.draw do
  devise_for :users
  resources :boardcategories, only: [:index] do
    resources :boardposts
  end



  resources :searches, only: [:index]
  get 'searches/advanced', to: 'searches#advanced'
  get 'searches/advanced_form', to: 'searches#advanced_form'


  resources :users
  root to: "pages#home"

end
