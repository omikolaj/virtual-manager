Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#welcome'

  resources :employees
  resources :dealerships do
    resources :vehicles
  end
  resources :vehicles
  
  get '/signup', to: 'employees#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/auth/github/callback', to: 'sessions#create'
  get '/omniauth', to: 'employees#omniauth'
  post '/omniauth/:id', to: 'employees#edit'
  
end
