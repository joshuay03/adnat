Rails.application.routes.draw do
  get 'signup' => 'users#new'
  get 'current/:id' => 'users#show'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  get 'create_organisation' => 'organisations#new'
  post 'create_organisation' => 'organisations#create'
  get 'edit_organisation/:id' => 'organisations#edit'
  post 'edit_organisation/:id' => 'organisations#update'
  get 'join_organisation/:id' => 'organisations#join'

  resources :users
end
