Rails.application.routes.draw do
  # Override the params accepted in the User Registration
  devise_for :users, controllers: { registrations: 'user/registrations' }

  resources :users, only: [:update] do
    resources :favorites, only: [:create, :destroy]
    resources :participations, only: [ :index, :create, :destroy ]
  end

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :organizations, only: [ :index, :show, :new, :create, :edit, :update, :destroy] do
    resources :admins, only: [:new, :create, :show, :edit, :update, :destroy]
    resources :posts
    resources :events
  end

  get '/feed', to: 'pages#feed'
end
