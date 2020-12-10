require 'rails_helper'

RSpec.describe 'Tweetモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:tweet) { build(:tweet, user_id: user.id) }

    context 'tweet_textカラム' do
      it '空欄でないこと' do
        tweet.tweet_text = ''
        expect(tweet.valid?).to eq false;
      end
      it '155文字以下であること' do
        tweet.tweet_text = Faker::Lorem.characters(number:156)
        expect(tweet.valid?).to eq false;
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Empathyモデルとの関係' do
      it '1:Nとなっている' do
        expect(Tweet.reflect_on_association(:empathies).macro).to eq :has_many
      end
    end
    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Tweet.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Tweet.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
# アソシエーションのテスト
