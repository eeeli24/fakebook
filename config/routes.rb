Rails.application.routes.draw do
  root 'static_pages#home'
  devise_for :users, :path => ''
  resources :users
  resources :friend_requests, only: [:index, :create, :update, :destroy]
  resources :posts
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  get 'about' => 'static_pages#about'
end
