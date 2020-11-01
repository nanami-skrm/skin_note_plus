class MyItem < ApplicationRecord

	has_many :todays_items
	belongs_to :user

	validates :item_name, presence: true
	validates :maker, presence: true

end
