Rails.application.routes.draw do
  get 'corrective/new'

  get 'corrective/show'
  post 'corrective/create'
  get 'corrective/edit'
  patch 'corrective/update'
  get 'corrective/print'

  get    'attendance/edit', to: 'attrecord#edit'
  patch    'attendance/update', to: 'attrecord#update'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  post   '/assume',  to: 'sessions#assume'
  delete '/logout',  to: 'sessions#destroy'
  get 'users/new'
  get 'users/show'
  get 'users/edit'
  get 'myTeam', to: 'users#myTeam'
  root to: 'static#home'
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
