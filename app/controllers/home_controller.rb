class HomeController < ApplicationController
    before_filter :update_poststreams

    def search
        @search=Post.search do
            fulltext params[:search]
        end
        @articles = @search.results
        @search1=User.search do
            fulltext params[:search]
        end
        @users = @search1.results
        respond_to do |format|

            format.html # index.html.erb
            format.json {render @users}

        end

    end

    def home
    end

    def votedup
        @post = Post.find(params[:id])
        @likercheck=@post.likers.where(id: current_user.id).first
        if(@likercheck.nil? || @likercheck.id!=current_user.id)
            @post.ups=@post.ups+1
            @post.likers << current_user
            @dislikercheck=@post.dislikers.where(:id == current_user.id).first
            if (!@dislikercheck.nil?)
                @post.downs=@post.downs-1
                @post.dislikers.delete(current_user)
            end
        end
        @post.save
        render :text => "<div class='up'></div>"+@post.ups.to_s+" likes <<<<<<<< <div class='down'></div>"+@post.downs.to_s+" dislikes"
    end

    def voteddown
        @post = Post.find(params[:id])
        @dislikercheck=@post.dislikers.where(id:  current_user.id).first
        if(@dislikercheck.nil?)
            @post.downs=@post.downs+1
            @post.dislikers << current_user
            @likercheck=@post.likers.where(:id == current_user.id).first
            if (!@likercheck.nil?)
                @post.ups=@post.ups-1
                @post.likers.delete(current_user)
            end
        end
        @post.save
        render :text => "<div class='up'></div>"+@post.ups.to_s+" likes <<<<<<<< <div class='down'></div>"+@post.downs.to_s+" dislikes"
    end


    def refreshposts
        render :partial => 'posts.html.erb', :locals => { :posts_streams => @posts_streams }
    end

    protected
    def update_poststreams
        require 'will_paginate/array' 
        @posts_streams = Post.find(:all, :order => 'posts.created_at DESC').paginate(:page => params[:page], :per_page => 5)
        #@posts_streams = Post.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
    end 

end
