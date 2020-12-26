class User::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to edit_user_user_path(current_user)
    end
    @your_interested_item = Item.joins(:interests).where(interests: {user_id: current_user.id})
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to edit_user_user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_user_path(@user)
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :image, :age, :skin_type)
  end

end
