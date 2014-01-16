LaughingAdventure::Application.routes.draw do
  resources :topics

    devise_for :views
    root :to => "home#index"
    devise_for :users, :controllers => {:registrations => "registrations"}
    resources :users 
    resources :posts do 
        resources :comments
    end
    get  "refresh"  => "home#refreshposts", :as => "refresh"
      post 'users/user_follow'
  post 'users/user_unfollow'
  post 'topics/user_follow'
  post 'topics/user_unfollow'

end
