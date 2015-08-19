Rails.application.routes.draw do
  root 'static_pages#home'
  devise_for :users, :path => '', controllers: { registrations: :registrations }
  resources :users, only: [:index, :show] do
    resources :friends, only: [:index, :destroy]
  end
  resources :friend_requests, only: [:index, :create, :update, :destroy]
  resources :posts, only: :create
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  get 'about' => 'static_pages#about'
end
