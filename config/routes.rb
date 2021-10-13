Rails.application.routes.draw do
  resources :posts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'main', to: 'main#login'
  post 'main', to: 'main#check_login'

  get 'register', to: 'main#register'
  post 'register', to: 'main#create_user'

  get 'feed', to: 'main#feed'
  get 'profile/:name', to: 'main#profile', as: 'profile'
  get 'my_profile', to: 'main#my_profile'
  
  post '/profile/:name/follow', to: "main#follow", as: "follow_user"
  post '/profile/:name/unfollow', to: "main#unfollow", as: "unfollow_user"

  post 'create_post', to: 'main#create_post'
  get 'create_post', to: 'main#new_post'

  get 'search_profile', to: 'main#search_profile'

  get 'logout', to: 'main#logout'
end
