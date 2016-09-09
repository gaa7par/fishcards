Rails.application.routes.draw do
  devise_for :users

  root 'home#show'

  resource :home, only: :show

  namespace :user do
    resources :languages do
      resources :flashcards, except: :index
    end
    resources :quizzes
  end

  resources :users
end
