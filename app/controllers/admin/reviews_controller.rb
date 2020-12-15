class Admin::ReviewsController < ApplicationController

  before_action :authenticate_admin!

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to request.referer
  end

end
