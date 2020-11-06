class Comment < ApplicationRecord

	belongs_to :user
	belongs_to :tweet

	validates :comment_text, presence: true

end
