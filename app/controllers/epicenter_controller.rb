class EpicenterController < ApplicationController

	before_filter :authenticate_user!, except: [:show_user]

  def feed
@images = ["2bikes.jpg","first.jpg","groupbike.jpg","tunnel.jpg"]
    @post = Post.new

    @followercount = 0
    User.all.each do |u|
      if u.following.include?(current_user.id)
        @followercount += 1
      end
    end

  	@following_posts = []
  
  	Post.all.each do |post|
  		if current_user.following.include?(post.user_id) || post.user_id == current_user.id
  			@following_posts.push(post)
  		end
  	end
  	if params[:search]
    @users = User.search(params[:search]).order("created_at DESC")
  else
    @users = User.all.order('created_at DESC')
  end
  end

   def show_user
    @user = User.find(params[:id])
  end

  def now_following
  	current_user.following.push(params[:id].to_i)
  	current_user.save

  	redirect_to :back
  end

  def unfollow
  	current_user.following.delete(params[:id].to_i)
  	current_user.save

  	redirect_to :back
  end

  def followers
    @user = User.find(params[:id])
    @users = []
    User.all.each do |u|
      if u.following.include?(@user.id)
        @users.push(u)
      end
    end
  end

  def following
    @user = User.find(params[:id])
    @users = []
    User.all.each do |u|
      if @user.following.include?(u.id)
        @users.push(u)
      end
    end
  end

end









