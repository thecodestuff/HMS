Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end
  namespace :admin do
    #get '', to: 'admin#index'
    root to: 'admin#index'
    resources :users
    #get '/users/:role' , to: 'users#index'
  end
end
