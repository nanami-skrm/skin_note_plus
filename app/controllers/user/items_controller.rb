class User::ItemsController < ApplicationController

	before_action :authenticate_user!

	def index
		@items = Item.all
		# @cleansings = Item.where(item_genre: 0)
		# @washes = Item.where(item_genre: 1)
		# @toners = Item.where(item_genre: 2)
		# @milky_lotions = Item.where(item_genre: 3)
		# @serums = Item.where(item_genre: 4)
		# @masks =  Item.where(item_genre: 5)
		# @pointcares = Item.where(item_genre: 6)
		# @others = Item.where(item_genre: 7)
	end

	def show
		@item = Item.find(params[:id])
		@reviews = Review.includes(:user).where(item_id: params[:id]).page(params[:page]).per(15)
		@review = Review.new
		@average_score = Review.where(item_id: params[:id]).average(:score)
	end

end
