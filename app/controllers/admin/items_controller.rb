class Admin::ItemsController < ApplicationController

	def index
		@items = Item.all
	end

	def new
		@item = Item.new
	end

	def create
		item = Item.new(item_params)
		if item.save
			redirect_to admin_items_path
		else
			@item = Item.new
			render "new"
		end

	end

	def edit
	end

	def update
	end

	def destroy
	end

	def item_params
		params.require(:item).permit(:item_name, :image, :item_genre, :maker)
	end


end
