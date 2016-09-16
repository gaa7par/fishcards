Rails.application.routes.draw do
  devise_for :users

  root 'home#show'

  resource :home, only: :show

  namespace :user do
    resources :languages do
      resources :flashcards, except: :index
    end
    resources :flashcards, only: [] do
      member do
        get :check_answer
      end
    end
  end

  resources :users
end
