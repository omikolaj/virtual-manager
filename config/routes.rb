Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#welcome'
  
  resources :dealerships do
    resources :vehicles
  end

  resources :employees
  post '/permissions', to: 'employees#permissions'

  resources :vehicles
  get '/reports', to: 'vehicles#reports'
  
  get '/signup', to: 'employees#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/auth/github/callback', to: 'sessions#create'

  post '/guestlogin', to: 'sessions#guest'
  
end
