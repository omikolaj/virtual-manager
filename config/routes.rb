Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#welcome'
  get '/home', to: 'application#home'
  
  resources :dealerships do
    resources :vehicles
  end
  get '/dealership_validation', to: 'dealerships#validation'

  resources :employees

  # Developer/API routes
  get '/authorize', to: 'sessions#authorize'
  get '/developer', to: 'github#developer'
  get '/api', to: 'sessions#api_create'
  post '/webhooks', to: "github#webhooks"
  post '/create_issue', to: 'github#create_issue'
  get '/issues', to: 'github#issues'
  post '/fork', to: 'github#fork'


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
