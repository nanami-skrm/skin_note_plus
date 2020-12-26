class User::InterestsController < ApplicationController

  before_action :authenticate_user!

	def create
    item = Item.find(params[:item_id])
    interest = Interest.new
    interest.user_id = current_user.id
    interest.item_id = params[:item_id]
    interest.save
    redirect_to request.referer
	end

	def destroy
    item = Item.find(params[:item_id])
    interest = current_user.interests.find_by(item_id: item.id)
    interest.destroy
    redirect_to request.referer
	end

end
