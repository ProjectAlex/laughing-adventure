LaughingAdventure::Application.routes.draw do
  devise_for :views
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users 
  resources :posts do 
		resources :comments
  end
	get  "refresh"  => "home#refreshposts", :as => "refresh"
end
