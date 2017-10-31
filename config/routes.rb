Rails.application.routes.draw do
<<<<<<< HEAD
=======


>>>>>>> 1bc5f33540dd82f69b704c7a3136419346fb7167
  get 'ato/new'
  post 'ato/create'
  get 'ato/edit'
  patch 'ato/update'
  get 'ato/show'
  delete 'ato/destroy'

  get '/coaching', to: 'coaching#link'
  get 'coaching/new'
  post "coaching/create"
  get 'coaching/edit'
  patch 'coaching/update'
  delete 'coaching/destroy'
  get 'coaching/show'

  #announcements routes
  get 'announcements/new'
  get 'announcements/edit'
  patch 'announcements/update'
  post 'announcements/create'
  delete 'announcements/delete'

  #corrective actions routes
<<<<<<< HEAD
  get '/discipline', to: 'corrective#link'
=======


  get '/discipline', to: 'corrective#link'

>>>>>>> 1bc5f33540dd82f69b704c7a3136419346fb7167
  get 'corrective/new'
  get 'corrective/show'
  post 'corrective/create'
  get 'corrective/edit'
  patch 'corrective/update'
  get 'corrective/print'

  #attendance routes
  get 'attendance/pto', to: 'attrecord#pto'
  get 'attendance/flexes', to: 'attrecord#flexes'
  get '/attendance', to: 'attrecord#link'
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
