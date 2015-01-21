Rails.application.routes.draw do
  get 'subscriptions/index'

  root to: 'visitors#index'

  resources :users, only: [ :index ] do
    resources :messages, only: [ :index ]
    resources :subscriptions, only: [ :index ]
  end

  namespace :api do
    resources :messages, :users, except: [:new, :edit]
    resources :subscriptions, only: [ :index, :create ] do
      member do
        post :cancel
        post :reactivate
      end
    end
  end

  # namespace path_helper hackery!
  get '/api/messages/:id', to: 'messages#show', as: :message
  get '/api/users/:id', to: 'users#show', as: :user
  get '/api/subscriptions/:id', to: 'subscriptions#show', as: :subscription
end
