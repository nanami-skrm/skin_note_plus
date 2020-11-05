class Tweet < ApplicationRecord

	has_many :empathies, dependent: :destroy
	has_many :comments, dependent: :destroy
	belongs_to :user
	validates :tweet_text, presence: true

	def empathized_by?(user)
		empathies.where(user_id: user.id).exists?
	end

end
