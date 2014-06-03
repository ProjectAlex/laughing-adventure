OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  	provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], :scope => 'email,user_birthday,read_stream,publish_actions'
	provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
	provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
	provider :gplus, ENV['GPLUS_KEY'], ENV['GPLUS_SECRET']
end
