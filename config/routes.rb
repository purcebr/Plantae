require 'sidekiq/web'
Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  
  # mount API::Root => '/api'

  root 'landing#index'

  authenticate :user, lambda { |u| u.is_global_admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
