require 'rails_helper'

RSpec.describe 'Reviewモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let(:admin) { create(:admin) }
    let(:item) { create(:item) }
    let!(:review) { build(:review, user_id: user.id, item_id: item.id) }

    context 'scoreカラム' do
      it '空欄でないこと' do
        review.score = ''
        expect(review.valid?).to eq false;
      end
    end
    context 'review_textカラム' do
      it '空欄でないこと' do
        review.review_text = ''
        expect(review.valid?).to eq false;
      end
      it '375文字以下であること' do
        review.review_text = Faker::Lorem.characters(number:376)
        expect(review.valid?).to eq false;
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Review.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Itemモデルとの関係' do
      it 'N:1となっている' do
        expect(Review.reflect_on_association(:item).macro).to eq :belongs_to
      end
    end
  end
end
