class User::ReviewsController < ApplicationController

	def create
		reviews = Review.new(review_params)
		reviews.save
		redirect_to request.referer
	end

	def destroy
	end

	private

	def review_params
		params[:review][:item_id] = params[:item_id]
		params[:review][:score] = params[:score]
		# ↑item_idとscoreがparameterのreviewの中に入っていないので、↓を実行する前にここで指定している
        params.require(:review).permit(:user_id, :item_id, :review_text, :score)
	end
end
