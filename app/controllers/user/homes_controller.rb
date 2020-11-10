class User::HomesController < ApplicationController

	def top
	end

	def about
	end

  def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
      user.age = 30
      user.skin_type = 0
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
    sign_in user
    redirect_to user_notes_path(year: Time.now.year, month: Time.now.month), notice: 'ゲストユーザーとしてログインしました。'
  end

end
