Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'signup', to: 'signup#create'
      
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'

      get 'home', to: 'home#index'

      post 'create_profile', to: 'profiles#create' 
      get 'profile', to: 'profiles#show' 
      
      get 'search_service', to: 'search_service#index'
      get 'search_service_result/:service_title', to: 'search_service#result'
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
