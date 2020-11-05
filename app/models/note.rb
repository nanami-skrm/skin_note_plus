class Note < ApplicationRecord

	has_many :todays_items, dependent: :destroy
	belongs_to :user

	validates :date, uniqueness: true

  enum condition: { 良い: 3, 普通: 2, 少し悪い: 1, 悪い: 0 }

end
