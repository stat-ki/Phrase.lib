Rails.application.routes.draw do

  # home_controller
  root "home#top"

  # devise_controller
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # users_controller
  resources :users, only: [:show]

  # posts_controller
  get "/notes" => "posts#notes"
  get "/shares" => "posts#shares"
  get "/first_post" => "posts#first_post"
  get "/posts/:id/translate" => "posts#translate"
  get "/posts/:id/search_items" => "posts#search_items"
  resources :posts, except: [:index]

  # favorites_controller
  post "/posts/:post_id/favorite" => "favorites#create"
  delete "/posts/:post_id/favorite" => "favorites#destroy"

  # search_controller
  post "/search_result" => "search#search_result"

  # gem 'shortener'
  get '/:id' => "shortener/shortened_urls#show"

end
