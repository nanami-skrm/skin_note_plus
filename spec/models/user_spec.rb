require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  # 名前が空欄で登録できない→名前を空欄で登録したらfalse
  # バリデーションしていない状態で失敗→設定したら成功
  # 登録できるかできないか 登録できたら失敗
  # エラーメッセージがなければ失敗

  describe 'バリデーションのテスト' do
    let(:user) { build(:user) }
    subject { test_user.valid? }
    context 'nameカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.name = ''
        is_expected.to eq false;
      end
      it '2文字以上であること' do
        test_user.name = Faker::Lorem.characters(number:1)
        is_expected.to eq false;
      end
      it '10文字以下であること' do
        test_user.name = Faker::Lorem.characters(number:11)
        is_expected.to eq false;
      end
    end

    context 'ageカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.age = ''
        is_expected.to eq false;
      end
    end

    context 'skin_typeカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.skin_type = ''
        is_expected.to eq false;
      end
    end
  end


  describe 'アソシエーションのテスト' do
    context 'Noteモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:notes).macro).to eq :has_many
      end
    end
    context 'MYItemモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:my_items).macro).to eq :has_many
      end
    end
    context 'Tweetモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:tweets).macro).to eq :has_many
      end
    end
    context 'Empathyモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:empathies).macro).to eq :has_many
      end
    end
    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context 'Interestモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:interests).macro).to eq :has_many
      end
    end
    context 'Reviewモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:reviews).macro).to eq :has_many
      end
    end
  end
end
# アソシエーションのテスト