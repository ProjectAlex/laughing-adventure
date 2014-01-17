LaughingAdventure::Application.routes.draw do
  resources :topics

    devise_for :views
    root :to => "home#index"
    devise_for :users, :controllers => {:registrations => "registrations"}
    resources :users 
    resources :posts do 
        resources :comments
    end
    
    #For AJAX
    get  "refresh"  => "home#refreshposts", :as => "refresh"
    get "votedup"  => "home#votedup", :as => "votedup"
    get  "voteddown"  => "home#voteddown", :as => "voteddown"
    
    post 'users/user_follow'
  post 'users/user_unfollow'
  post 'topics/user_follow'
  post 'topics/user_unfollow'

end
