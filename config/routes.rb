Rails.application.routes.draw do
  get 'home/index'

  # devise_for :users

  root 'home#index'

  namespace :user do
    resources :languages do
      resources :flashcards
    end
  end

  resources :users
end
