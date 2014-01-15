class CommentsController < ApplicationController
def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:body))
		@comment.commenter= current_user.name
		@comment.user = current_user
		respond_to do |format|
      if @comment.save
        format.html { redirect_to root_path }
      end
    end
	end
end
