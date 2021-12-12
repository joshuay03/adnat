Rails.application.routes.draw do
  root 'users#new'
  get 'signup' => 'users#new'
  get 'current/:id' => 'users#show'
  get 'edit_profile/:id' => 'users#edit'
  post 'edit_profile/:id' => 'users#update'
  get 'forgot_password' => 'users#edit_password'
  post 'forgot_password' => 'users#update_password'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  get 'create_organisation' => 'organisations#new'
  post 'create_organisation' => 'organisations#create'
  get 'edit_organisation/:id' => 'organisations#edit'
  post 'edit_organisation/:id' => 'organisations#update'
  get 'join_organisation/:id' => 'organisations#join'
  get 'leave_organisation/:id' => 'organisations#leave'
  get 'view_organisation/:id' => 'organisations#show'

  get 'create_shift/:organisation_id' => 'shifts#new'
  post 'create_shift/:organisation_id' => 'shifts#create'
  get 'edit_shift/:id' => 'shifts#edit'
  patch 'edit_shift/:id' => 'shifts#update'
  get 'delete_shift/:id' => 'shifts#destroy'

  resources :users
end
