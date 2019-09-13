Rails.application.routes.draw do
  get 'home/index'
  get 'home/about'
  devise_for :users
  root "home#index"
  resources :users, only: [:show, :edit, :update, :index]
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  Refile.secret_key = '93380a54f9cdd84b5f26a88684cba282ecdcba52cc24e2b19377ab70156da9122781b5b6d54660445d88c305efc963297e291964d95494c69c760b1bbb5a943a'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
