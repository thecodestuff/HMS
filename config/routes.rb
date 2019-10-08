Rails.application.routes.draw do
  
  root to: 'home#index'
  #devise_for :users, :controllers => { :registrations => 'admin/registrations' }
  devise_for :users, controllers: { omniauth_callbacks: 'admin/omniauth_callbacks' }

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
  end

  # devise_scope :user do
  #   get 'auth/github', to: 'admin/omniauth_callbacks#passthru'
  #   get 'auth/github/callback', to: 'admin/omniauth_callbacks#github'
  # end

  namespace :admin do
    root to: 'admin#index'
    resources :users
    resources :patients, only: %i[new create destroy update]
    resources :appointments, only: %i[index new create destroy update]
    resources :wards, only: %i[index create destroy update]
    resources :invoice, only: %i[index show]
    resources :physician, only: %i[update]
    get 'patient/invoice/:id', to: 'invoice#create', as: :create_invoice
    get 'patient/invoice/update/:id', to: 'invoice#update_status', as: :invoice_status
    get 'manage/patient', to: 'patients#patients'
    get 'payment/:id', to: 'patients#billing', as: 'payment'
    get 'manage/patient/:id', to: 'patients#update_discharge_date', as: :update_date
    get 'get_dataset', to: 'users#get_data'
    get 'appointments/cancel/:id', to: 'appointments#cancel_appointment', as: :cancel_appointment
    get 'appointments/calender', to: 'appointments#calender', as: :calender
    get 'physician/charges/:id', to: 'physician#charges', as: :charges
  end

  # routes for api
  namespace :api do
    get 'data/appointments', to: 'report#generate_appointment_report'
  end

  # Routes for maps api
  namespace :api do
    resources :maps
  end
end
