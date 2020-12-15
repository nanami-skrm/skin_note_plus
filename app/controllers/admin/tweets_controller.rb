class Admin::TweetsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @tweets = Tweet.includes(:empathies, :comments, :user).all.page(params[:page]).per(15)
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to request.referer
  end

end
