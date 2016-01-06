Rails.application.routes.draw do
  root 'landings#index'

  resources :books

  resources :authors, except: [:destroy] do
    resources :books
  end

  devise_for :users
end
