Rails.application.routes.draw do
  resources :tracks
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :posts
  get 'home/index'

  get 'tracks/getcoordinates/:id', to: "tracks#getcoordinates"

  root to: "home#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
