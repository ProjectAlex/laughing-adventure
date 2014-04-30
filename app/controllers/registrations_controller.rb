class RegistrationsController < Devise::RegistrationsController
  before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :password_confirmation,:date_of_birth,:att_file)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :email, :password, :password_confirmation, :current_password,:avatar,:date_of_birth,:att_file)}
  end

  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end
=begin
def update
    @user = User.find(current_user.id)
    email_changed = @user.email != params[:user][:email]
    is_facebook_account = !@user.provider.blank?

    successfully_updated = if !is_facebook_account
      @user.update_with_password(params[:user])
    else
      @user.update_without_password(params[:user])
    end

    if successfully_updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render "edit"
    end
  end
=end

def update
    if needs_password?(@user, user_params)
      if @user.update_with_password(user_params_password_update)
        flash[:notice] = 'User was successfully updated.'
      else
        error = true
      end
    else
      if @user.update_without_password(user_params)
        flash[:notice] = 'User was successfully updated.'
      else
        error = true
      end
    end

    if error
      flash[:error] = @user.errors.messages
      render action: "edit"
    else
	    redirect_to root_path
    end
  end
  private
  
def needs_password?(user, user_params)
  print '*'*100
  #!user_params[:current_password].blank?
  !user.encrypted_password.blank?
end

def user_params
  params[:user].permit(:email, :password, :password_confirmation, :username, :name, :date_of_birth, :avatar)
end

#Need :current_password for password update
def user_params_password_update
  params[:user].permit(:email, :password, :password_confirmation, :current_password, :username, :name, :date_of_birth, :avatar)
end

  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
  

end
