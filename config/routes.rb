Rails.application.routes.draw do
  devise_for :users

  root 'landings#index'
end
