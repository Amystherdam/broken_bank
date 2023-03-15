Rails.application.routes.draw do
  devise_for :clients, controllers: { registrations: 'registrations' }
  resources :account_transactions, except: [:edit, :update, :destroy]

  get 'home', to: 'home#index'
  post 'home/close-account', to: 'home#close_account'
  post 'home/new-account', to: 'home#new_account'

  get 'statement', to: 'statement#index'
  post 'statement/report', to: 'statement#statement_report'

  root "home#index"
end
