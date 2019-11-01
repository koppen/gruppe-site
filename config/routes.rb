# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resource :dashboard, :only => [:show]
  resources :groups do
    resources :members, :only => [:destroy, :index]
    resources :invitations, :only => [:create, :new, :destroy]
  end

  root :to => "dashboards#show"
end
