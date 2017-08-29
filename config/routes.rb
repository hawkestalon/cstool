Rails.application.routes.draw do
  #announcements route
  get 'announcements/new'
  get 'announcements/edit'
  patch 'announcements/update'
  post 'announcements/create'
  delete 'announcements/delete'

  #corrective actions route
  get 'corrective/new'
  get 'corrective/show'
  post 'corrective/create'
  get 'corrective/edit'
  patch 'corrective/update'
  get 'corrective/print'

  #attendance routes
  get    'attendance/edit', to: 'attrecord#edit'
  patch    'attendance/update', to: 'attrecord#update'

  #sessions routes
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  post   '/assume',  to: 'sessions#assume'
  delete '/logout',  to: 'sessions#destroy'

  #users routes
  get 'users/new'
  get 'users/show'
  get 'users/edit'
  get 'myTeam', to: 'users#myTeam'
  get 'teamchart', to: 'users#teamChart'

  root to: 'static#home'
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
