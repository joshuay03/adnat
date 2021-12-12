Rails.application.routes.draw do
  root 'users#new'
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
  get 'view_shifts/:id' => 'organisations#show'

  get 'create_shift/:organisation_id' => 'shifts#new'
  post 'create_shift/:organisation_id' => 'shifts#create'

  resources :users
end
