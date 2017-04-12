Rails.application.routes.draw do
  devise_for :users
  resources :boardcategories, only: [:index, :show]

  resources :boardposts

  resources :tags, only: [:new, :create] do
    resources :post_tags, only: [:new, :create]
  end

  resources :locations, except: [:update, :edit, :destroy]

  resources :searches, only: [:index]
  get 'searches/advanced', to: 'searches#advanced'
  get 'searches/advanced_form', to: 'searches#advanced_form'
  delete "/users/:id/connections" => "connections#delete", as: "delete_connection"


  resources :useraudiofiles
  resources :conversations
  resources :users do
    resources :user_conversations, shallow: true
  end

  resources :user do
    resources :connections, shallow: true
  end

# post "/users/:user_id/connections" => "connections#create", :as => :create_connection
  root to: "pages#home"

  mount ActionCable.server => '/cable'
end
