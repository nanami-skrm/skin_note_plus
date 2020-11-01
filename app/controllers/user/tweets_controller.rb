class User::TweetsController < ApplicationController

	def index
		@tweet = Tweet.new
		@tweets = Tweet.all
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
	end

	def show
	end

	private
	def tweet_params
        params.require(:tweet).permit(:user_id, :tweet_text)
	end
end
