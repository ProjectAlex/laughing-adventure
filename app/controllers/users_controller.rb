class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def new
		@post = Post.new
  end
  def index
     
    @users = User.all
  end
  def show
    @user = User.friendly.find(params[:id])
  #  @user_posts = Post.where(posted_by_uid: @user.id).order('created_at DESC').load
    @user_posts = Post.where(posted_by_uid: @user.id).paginate(:page => params[:page], :per_page => 5)

  end
  
  def update
    @user = User.friendly.find(params[:id])
#puts @user.name
puts '--------------------------------------'   

puts '--------------------------------------'

    if current_user.has_role? :admin
	if @user.has_role? :admin
		@user.remove_role :admin
		@user.add_role(:user)
	else
		@user.remove_role :user
		@user.add_role(:admin)
	end
	
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.friendly.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
end
