Rails.application.routes.draw do
  resources :account_transactions, except: [:edit, :update, :destroy]
  get 'home', to: 'home#index'
  post 'home/close-account', to: 'home#close_account'
  post 'home/new-account', to: 'home#new_account'
  devise_for :clients, controllers: { registrations: 'registrations' }

  root "home#index"
end
