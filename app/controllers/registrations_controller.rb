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
 
  private
  
  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end

end
