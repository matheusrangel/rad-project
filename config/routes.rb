Rails.application.routes.draw do

  root   'sessions#new'
  get    'login'       => 'sessions#new'
  post   'login'       => 'sessions#create'
  delete 'logout'      => 'sessions#destroy'
  get    'signup'      => 'users#new'
  get    'home'        => 'static_pages#home'  

  resources :users
  resources :contacts

end
