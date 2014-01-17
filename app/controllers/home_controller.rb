class HomeController < ApplicationController
  before_filter :update_poststreams

  def home
  end

 def votedup
 @post = Post.find(params[:id])
 @post.ups=@post.ups+1
 @post.save
 render :text => "<div class='up'></div>"+@post.ups.to_s+" likes"
 end

 def voteddown
 @post = Post.find(params[:id])
 @post.downs=@post.downs+1
 @post.save
 render :text => "<div class='down'></div>"+@post.downs.to_s+" dislikes"
 end


  def refreshposts
  	render :partial => 'posts.html.erb', :locals => { :posts_streams => @posts_streams }
  end

protected
  def update_poststreams
  	@posts_streams = Post.order('created_at DESC').load
  end 
 
end
