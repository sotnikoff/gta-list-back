Rails.application.routes.draw do

  namespace :auth do
    post '', to: 'sessions#create'
    delete '', to: 'sessions#destroy'
    get '', to: 'sessions#validate'
    post 'invitations', to: 'invitations#create'
    put 'invitations', to: 'invitations#proceed'
    get 'invitations', to: 'invitations#user_by_token'
  end

  resources :idiots, only: %i[index show create update destroy] do
    get 'restore', on: :member
    put 'sync', on: :collection
    post 'create_or_update_batch', on: :collection
  end

  resources :mamken_schutkens, only: %i[create index]
  resources :user_tokens, only: %i[create index destroy]
  resources :users, only: %i[index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
