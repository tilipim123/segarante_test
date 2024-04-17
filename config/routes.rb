# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :users
  post 'login', to: 'sessions#create'
  patch 'users/:id/change_password', to: 'sessions#change_password'
end
