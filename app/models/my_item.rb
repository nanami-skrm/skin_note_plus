class MyItem < ApplicationRecord

	has_many :todays_items
	belongs_to :user

end
