# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :authors
  resources :journals
  resources :articles
  resources :chapters
  resources :reports
end
