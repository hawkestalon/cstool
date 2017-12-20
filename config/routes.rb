Rails.application.routes.draw do
  get 'password_r_esets/new'

  get 'password_r_esets/edit'

  #miseed hours routes
  get 'miss/new'
  post 'miss/create'
  get 'miss/edit'
  post 'miss/update'
  get 'miss/show'
  delete 'miss/destroy'

  #ato routes
  get 'ato/new'
  post 'ato/create'
  get 'ato/edit'
  patch 'ato/update'
  get 'ato/show'
  delete 'ato/destroy'

  #coaching routes
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
  get '/discipline', to: 'corrective#link'
  get 'corrective/new'
  get 'corrective/show'
  post 'corrective/create'
  get 'corrective/edit'
  patch 'corrective/update'
  get 'corrective/print'

  #attendance routes
  get 'attendance/pto', to: 'attrecord#flexes'
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
  get 'user/csv-final', to: 'users#csvFinal'
  post 'user/csv-final', to: 'users#csvFinal'
  post 'user/csv-process', to: 'users#csv'
  get 'user/csv', to: 'users#csvUser'
  get 'users/new'
  get 'users/show'
  get 'users/edit'
  get 'myTeam', to: 'users#myTeam'
  get 'teamchart', to: 'users#teamChart'
  get 'users/password'
  post 'users/confirm'

  root to: 'static#home'
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
