Rails.application.routes.draw do
  root to: 'visitors#index'

  get 'users/list'
  get 'messages/list'

  resources :users, only: %i{index} do
    resources :messages
  end

  namespace :api do
    resources :messages, :users, except: [:new, :edit]
  end

  # namespace path_helper hackery!
  get '/api/messages/:id', to: 'messages#show', as: :message
  get '/api/users/:id', to: 'users#show', as: :user

end
