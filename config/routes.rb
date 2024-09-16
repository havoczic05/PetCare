Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
  resources :users

  resources :services do
    resources :bookings
  end
  patch "bookings/:id", to: "bookings#accept_booking", as: :accept_booking
  get "bookings", to: "bookings#index", as: :bookings
  get 'landing', to: 'services#landing'
  resources :bookings, only: [] do
    resources :activities
  end
  resources :pets
end
