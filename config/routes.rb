Rails.application.routes.draw do
  get 'pets/edit'
  get 'pets/update'
  get 'pets/destroy'
  devise_for :users
  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
  resources :users
  resources :services, only: %i[index new create]

  # Defines the root path route ("/")
  # root "posts#index"
  resources :pets
end
