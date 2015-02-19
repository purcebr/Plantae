Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  
  # mount API::Root => '/api'

  root 'landing#index'
end
