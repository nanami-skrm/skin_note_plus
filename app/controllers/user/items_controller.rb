class User::ItemsController < ApplicationController

	before_action :authenticate_user!

	def index
		@items = Item.all
		@item_genres = Item.item_genres.keys
		if params[:item_genre].present?
			items = Item.find(Review.group(:item_id).order('avg(score) desc').pluck(:item_id))
			@ranking_items = items.select{ |item| item.item_genre == params[:item_genre] }
			@title = (params[:item_genre])
		else
			@ranking_items = Item.find(Review.group(:item_id).order('avg(score) desc').limit(5).pluck(:item_id))
			@title = "総合"
		end
	end

	def show
		@item = Item.find(params[:id])
		@reviews = Review.includes(:user).where(item_id: params[:id]).page(params[:page]).per(15)
		@review = Review.new
		@average_score = Review.where(item_id: params[:id]).average(:score)
	end

end
