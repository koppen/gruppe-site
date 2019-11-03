# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resource :dashboard, :only => [:show]
  resources :groups do
    resources :members, :only => [:destroy, :index]
    resource :membership, :only => [:show, :update]
    resources :invitations, :only => [:create, :new, :destroy]
  end
  resources :invitations, :only => [:destroy, :show, :update]

  root :to => "dashboards#show"
end
