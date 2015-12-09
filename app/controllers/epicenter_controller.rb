class EpicenterController < ApplicationController
  def feed
  	@following_tweets = []
  	@tweets = Tweet.all

  	@tweets.each do |tweet|
  		if current_user.following.include?(tweet.user.id)
  			@following_tweets.push(tweet)
  		end
	end

	@follower_count = 0
	@users = User.all
	@users.each do |user|
		if user.following.include?(current_user.id)
			@follower_count += 1
		end
	end
end

  def show_user
  	@user = User.find(params[:id]) 
  end

  def now_following
  	@user = User.find(params[:follow_id])
  	current_user.following.push(params[:follow_id].to_i)
  	current_user.save
	redirect_to user_profile_path(id: @user.id) 
  end

  def unfollow
  	@user = User.find(params[:unfollow_id])
	current_user.following.delete(params[:unfollow_id].to_i)
	current_user.save
  	redirect_to user_profile_path(id: @user.id) 
  end
end
