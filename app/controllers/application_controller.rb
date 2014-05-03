class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  around_filter :set_time_zone

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  
  def fb_user
	(session[:fb_access_token] && session[:fb_user_uid]) ? FBGraph::Client.new(:client_id => GRAPH_APP_ID, :secret_id => GRAPH_SECRET, :token => session[:fb_access_token]).selection.me.info! : nil
  end

  private

    def set_time_zone
		old_time_zone = Time.zone
		Time.zone = browser_timezone if browser_timezone.present?
		yield
		ensure
		Time.zone = old_time_zone
    end

    def browser_timezone
	cookies["browser.timezone"]
    end




end
