Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  namespace :user do
    resources :languages do
      resources :flashcards
    end
  end

  resources :users
end
