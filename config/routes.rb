Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
  resources :users
  resources :services
  get 'landing', to: 'services#landing'

  # Defines the root path route ("/")
  # root "posts#index"
  resources :pets
end
