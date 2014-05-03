class UsersController < ApplicationController

    before_filter :authenticate_user!

    def new
        @post = Post.new
    end
    def index
        @users = User.all
        respond_to do |format|
            format.html
            format.json {render json: @users }
        end

    end
    def show
        @user = User.friendly.find(params[:id])
        #  @user_posts = Post.where(posted_by_uid: @user.id).order('created_at DESC').load
		if session[:fb_token]
                        @graph = Koala::Facebook::API.new(session[:fb_token], GRAPH_SECRET)
                        @fb = @graph.get_connections("me", "feed")
                end

        @user_posts = Post.where(posted_by_uid: @user.id).paginate(:page => params[:page], :per_page => 5)
        respond_to do |format|
            format.html
            format.json {render json: @user}

        end
    end

        def update
            @user = User.friendly.find(params[:id])
            #puts @user.name
            puts '--------------------------------------'   

            puts '--------------------------------------'

            if current_user.has_role? :admin
                if @user.has_role? :admin
                    @user.remove_role :admin
                    @user.add_role(:user)
                else
                    @user.remove_role :user
                    @user.add_role(:admin)
                end

                redirect_to users_path, :notice => "User updated."
            else
                redirect_to users_path, :alert => "Unable to update user."
            end
        end 

        def destroy
            authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
            user = User.friendly.find(params[:id])
            unless user == current_user
                user.destroy
                redirect_to users_path, :notice => "User deleted."
            else
                redirect_to users_path, :notice => "Can't delete yourself."
            end
        end
    end

