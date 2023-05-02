Rails.application.routes.draw do
  get 'search/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'
  resources :search, only: [:index]

  resources :categories, only: %i[index show create edit update destroy]
  resources :category_tools, only: %i[create destroy]

  resources :tools, only: %i[index show create edit update destroy]
  resources :users, only: %i[index show create edit update destroy]
  resources :tool_users, only: %i[create destroy]
end
