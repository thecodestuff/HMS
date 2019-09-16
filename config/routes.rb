Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, :controllers => { :registrations => 'admin/registrations' }

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
  end

  namespace :admin do
    root to: 'admin#index'
    resources :users
    resources :patients, only: %i[new create destroy update]
    resources :appointments, only: %i[index new create destroy update]
    resources :wards, only: %i[index create destroy update]
    resources :invoice, only: %i[index]
    get 'patient/invoice/:id', to: 'invoice#create', as: :invoice
    get 'patient/invoice/update/:id', to: 'invoice#update_status', as: :invoice_status
    get 'manage/patient', to: 'patients#patients'
    get 'payment/:id', to: 'patients#billing', as: 'payment'
  end
end
