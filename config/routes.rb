Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'signup', to: 'signup#create'
      
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'

      get 'home', to: 'home#index'

      post 'create_profile', to: 'profiles#create' 
      get 'profile', to: 'profiles#show' 
      
      get 'tiradors/:service_title', to: 'tiradors#index'
      get 'tiradors/id/:tirador_id', to: 'tiradors#show'

      post 'hire_tirador', to: 'hirings#create'

      get 'notifications/:user_id', to: 'notifications#index'
    end
  end
end
