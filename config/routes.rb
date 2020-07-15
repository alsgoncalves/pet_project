Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:update] do
    resources :favorites, only: [:create, :destroy]
    resources :participations, only: [ :index, :create, :destroy ]
  end

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :organizations, only: [ :index, :show, :new, :create] do
    resources :posts
    resources :events
  end

end
