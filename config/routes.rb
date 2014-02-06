LaughingAdventure::Application.routes.draw do
    devise_for :views
    root :to => "home#index"
    match '/search', :to => "home#search" , :via => "get"
    devise_for :users, :controllers => {:registrations => "registrations"}
    resources :users 
    resources :posts do 
        resources :comments
    end
    
    resources :messages do
    collection do
      get 'compose', :to=>'messages#new', :as=>:compose
      get 'index', :to=> 'messages#index', :as=> :index
      get 'sent', :to=> 'messages#sent', :as=> :sent
      post 'reply', :to=> 'messages#reply', :as=> :reply
      post 'trash', :to=> 'messages#trash', :as=> :trash
    end
  end
    
    patch 'show', :to=> 'messages#show', :as=> :show
    
    #For AJAX
    get  "refresh"  => "home#refreshposts", :as => "refresh"
    get "votedup"  => "home#votedup", :as => "votedup"
    get  "voteddown"  => "home#voteddown", :as => "voteddown"
    get  "message"  => "messages#unreadcount", :as => "unreadmessages"

    post 'users/user_follow'
    post 'users/user_unfollow'
    post 'topics/user_follow'
    post 'topics/user_unfollow'

end
