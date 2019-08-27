Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, :controllers => {  :registrations => 'admin/registrations' }

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  namespace :admin do
    root to: 'admin#index'
    resources :users
    resources :patients, only:[:new,:create]
  end
end
