Rails.application.routes.draw do
  root to: "tweets#index"
  
  get "/profile", to: "users#show", as: "users"

  resources :likes
  resources :tweets
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
