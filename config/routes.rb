Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'landings#index'

  resources :books

  resources :authors, except: [:destroy] do
    resources :books
  end

  devise_for :users
end
