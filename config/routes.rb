Rails.application.routes.draw do
  # home_controller
  root "home#top"

  # devise_controller
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
  }
  # users_controller
  resources :users, only: [:show]

  # posts_controller
  get "/notes" => "posts#notes"
  get "/shares" => "posts#shares"
  get "/first_post" => "posts#first_post"
  get "/posts/:id/translate" => "posts#translate"
  resources :posts, except: [:index]

  # sources_controller
  resources :sources, only: [:show, :update]

  # favorites_controller
  post "/posts/:post_id/favorite" => "favorites#create"
  delete "/posts/:post_id/favorite" => "favorites#destroy"
  get "users/:id/favorite" => "favorites#index"

  # search_controller
  post "/search_result" => "search#search_result"
  get "/posts/:id/search_items" => "search#search_items"

  # gem 'shortener'
  get '/:id' => "shortener/shortened_urls#show"
end
