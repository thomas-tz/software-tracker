Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resources :tools, only: [:index, :show, :create, :update]
  resources :tool_users, only: [:create, :destroy]

  resources :users, only: [:index, :show, :create]
  resources :categories, only: [:index, :show, :create]
end
