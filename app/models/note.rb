class Note < ApplicationRecord

	has_many :todays_items, dependent: :destroy
	belongs_to :user

end
