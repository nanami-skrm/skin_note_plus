class User::ReviewsController < ApplicationController

	def create
		reviews = Review.new(review_params)
		reviews.save!
		redirect_to request.referer
	end

	def destroy
	end

	private

	def review_params
		params[:review][:item_id] = params[:item_id]
		params[:review][:score] = params[:score]
        params.require(:review).permit(:user_id, :item_id, :review_text, :score)
	end
end
