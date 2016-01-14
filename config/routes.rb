Rails.application.routes.draw do
  root 'landings#index'

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :books do
    resources :reviews, only: [:new, :create, :destroy]
  end

  resources :reviews

  resources :users, only: [:show]

  resources :authors, except: [:destroy] do
    resources :books
  end

  resources :results, only: [:index]

  get '/search' => 'search#index'

end
