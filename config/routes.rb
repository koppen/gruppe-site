# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resource :dashboard, :only => [:show]
  resources :groups

  root :to => "dashboards#show"
end
