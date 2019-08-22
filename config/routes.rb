Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  namespace :admin do
    get '', to: 'admin#index'
    resources :users
    #get '/users/:role' , to: 'users#index'
  end
end
