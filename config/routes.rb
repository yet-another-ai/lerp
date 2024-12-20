Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"

  # /auth
  resources :auth, only: [:index] do
    post "/", to: "auth#create" # mock action to generate route
    get "/callback", to: "sessions#create"
  end

  # /locale
  resources :locale, only: [] do
    patch "/", action: :update, on: :collection
  end

  # /sessions
  resources :sessions, only: [:index, :create] do
    delete "/", to: "sessions#destroy", on: :collection
  end

  # /books
  resources :books, only: [:index, :create, :new]

  resources :users
end
