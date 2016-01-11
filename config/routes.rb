Rails.application.routes.draw do
  devise_for :admins, { registrations: 'registrations'}
  root 'landings#index'

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :books

  resources :authors, except: [:destroy] do
    resources :books
  end
end
