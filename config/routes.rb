Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resources :categories, only: [:index, :show, :create]
  resources :category_tools, only: [:update, :destroy]

  resources :tools, only: [:index, :show, :create]
  resources :users, only: [:index, :show, :create]
  resources :tool_users, only: [:create, :destroy]
end
