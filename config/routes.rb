Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
  resources :users

  resources :services do
    resources :bookings
  end

  get "bookings", to: "bookings#index", as: :bookings
  get 'landing', to: 'services#landing'

  resources :bookings, only: [] do
    resources :reviews, except: [:index]
    member do
      patch :accept
      patch :reject
    end
    resources :activities
  end

  resources :pets
end
