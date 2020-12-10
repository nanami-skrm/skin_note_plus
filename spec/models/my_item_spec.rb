require 'rails_helper'

RSpec.describe 'MyItemモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:my_item) { build(:my_item, user_id: user.id) }

    context 'item_nameカラム' do
      it '空欄でないこと' do
        my_item.item_name = ''
        expect(my_item.valid?).to eq false;
      end
    end
    context 'makerカラム' do
      it '空欄でないこと' do
        my_item.maker = ''
        expect(my_item.valid?).to eq false;
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'TodaysItemモデルとの関係' do
      it '1:Nとなっている' do
        expect(MyItem.reflect_on_association(:todays_items).macro).to eq :has_many
      end
    end
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(MyItem.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
# アソシエーションのテスト
