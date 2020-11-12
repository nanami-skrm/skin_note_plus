class Admin::ItemsController < ApplicationController

	before_action :authenticate_admin!

	def index
		@items = Item.all
	end

	def show
		@item = Item.find(params[:id])
		@reviews = Review.where(item_id: params[:id])
		@average_score = Review.where(item_id: params[:id]).average(:score)
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
		@item = Item.find(params[:id])
	end

	def update
		item = Item.find(params[:id])
		item.update(item_params)
		redirect_to admin_items_path
	end

	def destroy
		item = Item.find(params[:id])
		item.destroy
		redirect_to admin_items_path
	end

	def item_params
		params.require(:item).permit(:item_name, :image, :item_genre, :maker)
	end


end
