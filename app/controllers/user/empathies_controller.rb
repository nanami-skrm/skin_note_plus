class User::EmpathiesController < ApplicationController

	def create
		tweet = Tweet.find(params[:tweet_id])
		empathy = Empathy.new
		empathy.user_id = current_user.id
		empathy.tweet_id = params[:tweet_id]
		empathy.save
		redirect_to request.referer
	end

	def destroy
		tweet = Tweet.find(params[:tweet_id])
		empathy = current_user.empathies.find_by(tweet_id: tweet.id)
		empathy.destroy
		redirect_to request.referer
	end

	# def empathy_params
	# 	params.require(:empathy).permit(:user_id, :tweet_id)
	# end

end