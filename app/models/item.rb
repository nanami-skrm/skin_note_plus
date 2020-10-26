class Item < ApplicationRecord

	has_many :interests, dependent: :destroy
	has_many :reviews, dependent: :destroy

end
