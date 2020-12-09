class Note < ApplicationRecord

	has_many :todays_items, dependent: :destroy
	has_many :my_items, through: :todays_items
	belongs_to :user

  validates :user_id, presence: true
  validates :date, presence: true
  validates :condition, presence: true

  enum condition: { とても良い: 4, 良い: 3, 普通: 2, 少し悪い: 1, 悪い: 0 }

end