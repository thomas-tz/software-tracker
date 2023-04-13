Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resources :tools, only: [:index, :show, :create]
  resources :users, only: [:index]
  resources :categories, only: [:index]
end
