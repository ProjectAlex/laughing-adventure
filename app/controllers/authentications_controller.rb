class AuthenticationsController < ApplicationController
  before_action :set_authentication, only: [:show, :edit, :update, :destroy]

  # GET /authentications
  # GET /authentications.json
  def index
    @authentications = current_user.authentications if current_user
  end

  # GET /authentications/1
  # GET /authentications/1.json
  def show
  end

  # GET /authentications/new
  def new
    @authentication = Authentication.new
  end

  # GET /authentications/1/edit
  def edit
  end


  # POST /authentications
  # POST /authentications.json
  def create
#     render :text => request.env["omniauth.auth"].to_yaml
  omniauth = request.env["omniauth.auth"]
  authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
  #render :text => omniauth.to_json
  if authentication
    flash[:notice] = "Signed in successfully using existing authentication."
    sign_in_and_redirect(:user, authentication.user)
  elsif current_user
    current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
    flash[:notice] = "Authentication successful."
    image_set(current_user,omniauth)
    update_omniauth(current_user,omniauth)
    redirect_to authentications_url
  else
    user = User.find_by_email(omniauth['info']['email'])
    if user
      flash[:notice] = "Signed in and added authentication successfully."
      user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      image_set(user,omniauth)
      update(user,omniauth)
      sign_in_and_redirect(:user, user)
    else
      user=User.new
    end
    user.apply_omniauth(omniauth)
    user.skip_confirmation!
    image_set(user,omniauth)
    if user.save
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, user)
    else
      session[:omniauth] = omniauth.except('extra')
      redirect_to new_user_registration_url
    end
  end
  end

  # PATCH/PUT /authentications/1
  # PATCH/PUT /authentications/1.json
  def update
    respond_to do |format|
      if @authentication.update(authentication_params)
        format.html { redirect_to @authentication, notice: 'Authentication was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @authentication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authentications/1
  # DELETE /authentications/1.json
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_authentication
      @authentication = Authentication.find(params[:id])
    end
    
    def image_set(user,omniauth)
      if omniauth.info.image.present? && omniauth.provider != 'linkedin' && user.avatar.blank?
	avatar_url = process_uri(omniauth.info.image+'?type=large')
	user.update_attribute(:avatar, URI.parse(avatar_url))
      end
    end

    def update_omniauth(user,omniauth)
      if omniauth.info.name.present?
      	user.update_attribute(:name,omniauth.info.name)
      end
      if omniauth.extra.raw_info.birthday.present?
	date=Date.strptime(omniauth.extra.raw_info.birthday,'%m/%d/%Y')
      	user.update_attribute(:date_of_birth,date)
      end
    end

    def process_uri(uri)
      require 'open-uri'
      require 'open_uri_redirections'
      open(uri, :allow_redirections => :safe) do |r|
	r.base_uri.to_s
      end
    end
 
    # Never trust parameters from the scary internet, only allow the white list through.
    def authentication_params
      params.require(:authentication).permit(:user_id, :provider, :uids)
    end
end
