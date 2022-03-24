Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "welcome#index"
  resources :ideas do
    resources :reviews, only:[:create, :destroy]
  end
  resources :users
  resources :sessions, only:[:new, :destroy, :create]


end
