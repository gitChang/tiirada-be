Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'signup', to: 'signup#create'
      
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'

      get 'home', to: 'home#index'

      post 'profile/create/', to: 'profiles#create' 
      get 'profile', to: 'profiles#show' 
      
      get 'tiradors/service/:service_request', to: 'tiradors#index'
      get 'tirador/:tirador_id', to: 'tiradors#show'
      post 'tirador/request_service/', to: 'hirings#create'

      get 'notifications', to: 'notifications#index'
      get 'notification/:id', to: 'notifications#show'
    end
  end
end
