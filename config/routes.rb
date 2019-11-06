Rails.application.routes.draw do
   root 'friends#index'
   resources :friends, only: [:new, :create]
end
