Rails.application.routes.draw do
  get 'services/show'
  get 'services/edit'
  get 'pets/edit'
  get 'pets/update'
  get 'pets/destroy'
  devise_for :users
  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
  # root "posts#index"
  resources :pets
end
