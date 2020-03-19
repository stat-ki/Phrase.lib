Rails.application.routes.draw do

  # home_controller
  root "home#top"

  # devise_controller
  devise_for :users
  # users_controller
  resources :users, only: [:show]

  # posts_controller
  resources :posts, except: [:index]
  get "/notes" => "posts#notes"
  get "/shares" => "posts#shares"
  get "/first_post" => "posts#first_post"

  # favorites_controller
  post "/posts/:post_id/favorite" => "favorites#create"
  delete "/posts/:post_id/favorite" => "favorites#destroy"

  # search_controller
  post "/search_result" => "search#search"

end
