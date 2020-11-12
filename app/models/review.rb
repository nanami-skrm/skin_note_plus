class Review < ApplicationRecord

	belongs_to :user
	belongs_to :item
  validates :score, presence: true
  validates :review_text, presence: true

end
