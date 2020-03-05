# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts do
    get :feeds, on: :collection
  end

  resources :users do
    member do
      get :following, :followers
    end
  end

  controller :sessions do
    get 'login' => :new, as: :login
    post 'login' => :create
    delete 'logout' => :destroy, as: :logout
  end

  resources :relationships, only: %i[create destroy]

  root 'sessions#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
