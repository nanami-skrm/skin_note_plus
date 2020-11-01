class User::MyItemsController < ApplicationController

	def index
		@my_item = MyItem.new
		@my_items = MyItem.where(user_id: current_user.id)
	end

	def create
		my_item = MyItem.new(my_item_params)
		my_item.user = current_user
		if my_item.save
			redirect_to request.referer, notice: "You have created address successfully."
		else
			@my_item = MyItem.new
			@my_items = MyItem.where(user_id: current_user.id)
			render "index"
		end
	end

	def edit
	end

	def update
	end

	def destroy
		my_item = MyItem.find(params[:id])
		my_item.destroy
		redirect_to request.referer
	end

	private

	def my_item_params
		params.require(:my_item).permit(:user_id, :item_name, :maker)
	end


end
