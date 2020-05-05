Rails.application.routes.draw do
  root  "contests#index"

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

    resources :contests do
      resources :votes
      resources :items do
        resources :votes
      end
    end

  resources :pages
  resources :tags

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
