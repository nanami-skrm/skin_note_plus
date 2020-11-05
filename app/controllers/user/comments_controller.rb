class User::CommentsController < ApplicationController

	def create
		tweet = Tweet.find(params[:tweet_id])
		comment = Comment.new(comment_params)
		comment.user_id = current_user.id
		comment.tweet_id = tweet.id
		comment.save
		redirect_to request.referer
	end

	def destroy
	end

	private

	def comment_params
		params.require(:comment).permit(:user_id, :tweet_id, :comment_text)
	end
end