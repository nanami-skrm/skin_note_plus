class User::TweetsController < ApplicationController

	before_action :authenticate_user!

	def index
		@tweet = Tweet.new
		@tweets = Tweet.includes(:empathies, :comments, :user).all.page(params[:page]).per(15)
		@your_tweets = Tweet.includes(:comments, :empathies).where(user_id: current_user.id)
		@your_empathied_tweet_ids = Tweet.joins(:empathies).where(empathies: {user_id: current_user.id}).pluck(:id)
		@empathies_count = 0
		@comments_count = 0
		@your_tweets.each do |tweet|
			@empathies_count += tweet.empathies.size
			@comments_count += tweet.comments.size
		end
	end

	def current_index
		@your_tweets = Tweet.includes(:empathies, :comments, :user).where(user_id: current_user.id)
		@your_empathied_tweet_ids = Tweet.joins(:empathies).where(empathies: {user_id: current_user.id}).pluck(:id)
	end

	def create
		@tweet = Tweet.new(tweet_params)
		@tweet.user = current_user
		if @tweet.save
			redirect_to request.referer
		else
			@tweets = Tweet.includes(:empathies, :comments, :user).all.page(params[:page]).per(15)
			@your_tweets = Tweet.includes(:comments, :empathies).where(user_id: current_user.id)
			@your_empathied_tweet_ids = Tweet.joins(:empathies).where(empathies: {user_id: current_user.id}).pluck(:id)
			@empathies_count = 0
			@comments_count = 0
			@your_tweets.each do |tweet|
				@empathies_count += tweet.empathies.size
				@comments_count += tweet.comments.size
			end
			render "index"
		end
	end

	def destroy
		tweet = Tweet.find(params[:id])
		tweet.destroy
		redirect_to request.referer
	end

	def show
		@tweet = Tweet.find(params[:id])
		@comment = Comment.new
	end

	private

	def tweet_params
    params.require(:tweet).permit(:user_id, :tweet_text)
	end

end
