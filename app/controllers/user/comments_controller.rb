class User::CommentsController < ApplicationController

	before_action :authenticate_user!

	def create
		@tweet = Tweet.find(params[:tweet_id])
		@comment = Comment.new(comment_params)
		@comment.user_id = current_user.id
		@comment.tweet_id = @tweet.id
		if @comment.save
			redirect_to request.referer
		else
			redirect_to request.referer, flash: { error: @comment.errors.full_messages }
		end
	end

	def destroy
	end

	private

	def comment_params
		params.require(:comment).permit(:user_id, :tweet_id, :comment_text)
	end
end