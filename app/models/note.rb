class Note < ApplicationRecord

	has_many :todays_items, dependent: :destroy
	belongs_to :user

    enum condition: { 良い: 0, 普通: 1, 少し悪い: 2, 悪い: 3 }
end
