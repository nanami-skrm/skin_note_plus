require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let(:tweet) { create(:tweet) }
    let!(:comment) { build(:comment) }

    context 'comment_textカラム' do
      it '空欄でないこと' do
        comment.comment_text = ''
        expect(comment.valid?).to eq false;
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Tweetモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:tweet).macro).to eq :belongs_to
      end
    end
  end
end
# アソシエーションのテスト
