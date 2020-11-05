class User::TweetsController < ApplicationController

	def index
		@tweet = Tweet.new
		@tweets = Tweet.all
		@your_tweets = Tweet.where(user_id: current_user.id)
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
