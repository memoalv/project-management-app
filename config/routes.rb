Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: 'home#show'

  resources :organizations, only: %i[edit]

  resources :projects, only: %i[index new create destroy]
end
