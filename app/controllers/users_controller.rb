class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def new
		@post = Post.new
  end
  def index
     
    @users = User.all
  end
  def show

    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.has_role? :admin
			@user.add_role(:admin) #will change to admin but nothing else. Form input variable name ? views/users/_users.html.erb?
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
end
