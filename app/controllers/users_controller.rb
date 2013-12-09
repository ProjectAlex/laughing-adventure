class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
     
    @users = User.all
  end
  def show

    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @role = Role.find(params[:id])
    if @user.update_attributes(:as => :admin)
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
