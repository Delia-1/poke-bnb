Rails.application.routes.draw do
  devise_for :users
  root to: "pokemons#index"
  resources :pokemons, only: [:index, :show, :new, :create, :destroy] do
    resources :rentings, only: [:new, :create, :index]
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get 'dashboard', to: 'pages#dashboard'
  get 'memory', to: 'pages#memory'

  # Defines the root path route ("/")
  # root "posts#index"
end
