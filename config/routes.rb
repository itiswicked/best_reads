Rails.application.routes.draw do
 root "books#new"

 # resources :books do
 #   resources :authors, only: [:create]
 # end

resources :books

 resources :authors, except: [:destroy] do
   resources :books
 end
end
