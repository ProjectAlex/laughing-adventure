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

   @Role = @user.role_ids.name
puts @Role
puts '--------------------------------------'
    if current_user.has_role? :admin
#			@user.add_role(@Role) #will change to admin but nothing else. Form input variable name ? views/users/_users.html.erb?
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
