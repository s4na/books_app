# frozen_string_literal: true

Rails.application.routes.draw do
  resources :books do
    resources :comments
  end

  resources :reports do
    resources :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
