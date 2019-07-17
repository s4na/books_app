# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect("/books")

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",

    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users

  resources :books do
    resources :comments
  end

  resources :reports do
    resources :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
