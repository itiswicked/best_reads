Rails.application.routes.draw do
  root 'landings#index'

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :books do
    resources :reviews, only: [:new, :create, :destroy]
  end

  resources :reviews, only: [:new, :create, :destroy]

  resources :users, only: [:show]

  resources :authors, except: [:destroy] do
    resources :books
  end

  namespace :api do
    namespace :v1 do
      resources :reviews, only: [] do
        scope :votes, only: [:create_upvote, :create_downvote, :delete_upvote, :delete_downvote] do
          post 'upvote', to: 'votes#create_upvote'
          post 'downvote', to: 'votes#create_downvote'
          delete 'upvote', to: 'votes#delete_upvote'
          delete 'downvote', to: 'votes#delete_downvote'
        end
      end
    end
  end

  resources :results, only: [:index]

  get '/search' => 'search#index'
end
