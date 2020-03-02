Rails.application.routes.draw do
  resources :idiots, only: %i[index show create update destroy] do
    get 'restore', on: :member
    put 'sync', on: :collection
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
