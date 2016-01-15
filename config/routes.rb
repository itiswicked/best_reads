Rails.application.routes.draw do

  root 'books#index'

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :books do
    resources :reviews, only: [:new, :create, :destroy]
  end

  resources :reviews, only: [:new, :create, :destroy] do
    resources :votes, only: [:upvote, :downvote] do
      collection do
        post 'upvote'
        post 'downvote'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :votes, only: [:upvote, :downvote] do
        collection do
          post 'upvote'
          post 'downvote'
        end
      end
    end
  end

  resources :reviews

  resources :users, only: [:show]

  resources :authors, except: [:destroy] do
    resources :books
  end

  resources :results, only: [:index]

  get '/search' => 'search#index'

end
