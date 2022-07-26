Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :expenses, only: [:index, :create, :destroy]
  resources :users, only: [:index, :create, :destroy, :show]
  post 'authenticate', to: 'authentication#create'
  # Defines the root path route ("/")
  # root "articles#index"
end
