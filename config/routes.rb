# frozen_string_literal: true

Rails.application.routes.draw do
  get 'verboices/index'
  get 'verboices/create'
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  guisso_for :user

  root 'welcome#index'

  resources :threads, only: %i[index create show] do
    post :continue, on: :collection
  end

  resources :verboices, only: [:index, :create]
end
