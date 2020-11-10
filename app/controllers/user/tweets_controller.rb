class User::TweetsController < ApplicationController

	before_action :authenticate_user!

	def index
		@tweet = Tweet.new
		@tweets = Tweet.all
		@your_tweets = Tweet.where(user_id: current_user.id)
		@empathies_count = 0
		@your_tweets.each do |tweet|
			@empathies_count += tweet.empathies.count
		end
		@comments_count = 0
		@your_tweets.each do |tweet|
			@comments_count += tweet.comments.count
		end

		# @your_tweets_empathies_count = Empathy.where
		# @your_tweets_comments_count = Comment.where(user_id: current_user.id).count
	end

	def create
		tweet = Tweet.new(tweet_params)
		tweet.user = current_user
		if tweet.save
			redirect_to request.referer
		else
			@tweet = Tweet.new
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
