Rails.application.routes.draw do
  devise_for :users
   root 'friends#index'
   resources :friends, only: [:new, :show, :create]
end
