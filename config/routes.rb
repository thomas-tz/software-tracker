Rails.application.routes.draw do
  get 'search/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  resources :search, only: [:index]

  resources :categories, only: [:index, :show, :create, :edit, :update, :destroy]
  resources :category_tools, only: [:update, :destroy]

  resources :tools, only: [:index, :show, :create, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy]
  resources :tool_users, only: [:create, :destroy]
end
