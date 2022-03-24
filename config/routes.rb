Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "welcome#index"
  resources :ideas do
    resources :reviews, only:[:create, :destroy]
    resources :likes, shallow: true, only: [:create, :destroy]
    get :liked, on: :collection
  end
  resources :users
  resources :sessions
  delete "/sessions",to: "sessions#destroy", as: :session_delete
  


end
