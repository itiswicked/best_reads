Rails.application.routes.draw do
  root 'landings#index'

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :users, only: [:show]

  resources :authors, except: [:destroy] do
    resources :books
  end

  resources :books do
    resources :reviews do
      post 'upvote', to: 'reviews#create_upvote'
      post 'downvote', to: 'reviews#create_downvote'
    end
  end
end
