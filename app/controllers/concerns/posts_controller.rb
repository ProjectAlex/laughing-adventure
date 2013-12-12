class PostsController < ApplicationController
		# GET /posts
    def index
    	@post = Post.find(:all, :order => 'posts.created_at DESC')
      respond_to do |format|
      format.html # index.html.erb
    end
  end

	# GET /posts/1
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
  	end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  def create
    @post = Post.new(params[:post])
    @post.posted_by_uid=current_user.id
    @post.posted_by=current_user.name
    @post.save
    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path }
        format.json { render :json => @post, :status => :created, :location => @post }
      else
        format.html { redirect_to root_path }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, :notice => 'Post was successfully updated.' }
       else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /posts/1
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
    end
  end
end
