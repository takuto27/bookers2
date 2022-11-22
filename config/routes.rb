Rails.application.routes.draw do
  devise_for :users
  get "/home/about" => "homes#about"
  resources :users, only: [:show, :edit, :index, :update]
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]
  root to: "homes#top"

end