class User::ItemsController < ApplicationController

	def index
		@items = Item.all

	end

	def show
		@item = Item.find(params[:id])
		@reviews = Review.where(item_id: params[:id])
		@review = Review.new
		@average_score = Review.where(item_id: params[:id]).average(:score)
	end

end
