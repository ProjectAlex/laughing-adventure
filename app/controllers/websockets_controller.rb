class WebsocketsController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    session[:websocket]='true'
    puts '*'*100
    puts 'connected !!!'
    broadcast_message :new_post, 'try'
    debugger
  end

  def pushpost
    #new_post = Post.latest
    broadcast_message :new_post, 'trypost'
    puts '*'*100
    puts 'broadcasted !!!'
    debugger
    redirect_to root_path
  end

end
