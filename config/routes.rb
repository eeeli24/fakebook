Rails.application.routes.draw do
  root 'static_pages#home'
  devise_for :users, :path => ''
  resources :users
  get 'about' => 'static_pages#about'
end
