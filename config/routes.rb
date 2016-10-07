# frozen_string_literal: true
Rails.application.routes.draw do
  post '/rate' => 'rater#create', as: 'rate'
  devise_for :users, controllers: { registrations: 'registrations' }

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

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :ban
    end
  end
end
