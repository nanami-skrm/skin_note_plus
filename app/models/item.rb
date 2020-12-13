class Item < ApplicationRecord

	has_many :interests, dependent: :destroy
	has_many :reviews, dependent: :destroy

	validates :item_name, presence: true
	validates :item_genre, presence: true
	validates :maker, presence: true

	attachment :image

 	enum item_genre: { クレンジング: 0, 洗顔料: 1, 化粧水: 2, 乳液: 3, 美容液: 4, パック: 5, ポイントスペシャルケア: 6, その他: 7 }

  # def self.with_reviews_avarage_score
  #  joins(:reviews).group(:id).select('items.*, avg(reviews.score) as reviews_avarage_score')
  # end

  def reviews_avarage_score
    review_scores = reviews.pluck(:score)
    (review_scores.sum / review_scores.count.to_f).round(1)
    # reviews.average(:score).to_f.round(1)
    # Review.where(item_id: id).average(:score).to_f.round(1)
  end

end
