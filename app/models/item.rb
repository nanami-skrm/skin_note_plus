class Item < ApplicationRecord

	has_many :interests, dependent: :destroy
	has_many :reviews, dependent: :destroy

	attachment :image

 	enum item_genre: { クレンジング: 0, 洗顔料: 1, 化粧水: 2, 乳液: 3, 美容液: 4, パック: 5, ポイントスペシャルケア: 6, その他: 3 }
end
