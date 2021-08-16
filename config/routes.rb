Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: 'home#show'

  resources :organizations, only: %i[edit update]

  resources :projects, only: %i[index new show create edit update destroy]
end
