Rails.application.routes.draw do
  get 'signup' => 'users#new'
  resources :users
end
