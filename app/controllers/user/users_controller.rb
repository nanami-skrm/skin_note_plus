class User::UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to edit_user_user_path(current_user)
    end

  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
      redirect_to user_notes_path(year: Time.now.year, month: Time.now.month)
  end

  private
  def user_params
    params.require(:user).permit(:name, :age, :skin_type)
  end

end
