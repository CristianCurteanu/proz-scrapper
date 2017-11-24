# frozen_string_literal: true

Rails.application.routes.draw do
  root 'extractions#index'

  namespace :extractions do
    get :index
    get :edit
    get :show
    post :get
    post :create
  end
end
