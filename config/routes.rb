# frozen_string_literal: true

Rails.application.routes.draw do
  root 'movies#index'

  resources :movies do
    resources :reviews
  end

  resource :session, only: [:new, :create, :desstroy]
  get 'signin' => 'sessions#new'

  resources :users
  get 'signup' => 'users#new'
end
