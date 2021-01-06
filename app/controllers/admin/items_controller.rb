class Admin::ItemsController < ApplicationController

	before_action :authenticate_admin!

	def top
		@all_item_count = Item.all.size
		@all_tweet_count = Tweet.all.size
		@all_user_count = User.all.size
	end

	def index
		@items = Item.all
	end

	def show
		@reviews = Review.includes(:user, :item).where(item_id: params[:id]).page(params[:page]).per(15)
		@item = Item.find(params[:id])
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
