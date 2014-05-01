class FbOuathController < ApplicationController

  def callback
	auth = request.env['omniauth.auth']
   	token = auth['credentials']['token']
	session[:fb_access_token] = token
   	session[:fbgraph_uid] = auth['uid']
    	client = LaughingAdventure::Client.new(:client_id => GRAPH_APP_ID, :secret_id => GRAPH_SECRET, :token => token)
	user = client.selection.me.info!
	client.selection.user(user[:id]).feed.publish!(:message => 'test message', :name => 'test name')
    	render :text => client.selection.me.info!  
  end

end
