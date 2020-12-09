require 'rails_helper'

RSpec.describe 'Itemモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    let(:admin) { create(:admin) }
    let!(:item) { build(:item) }

    context 'item_nameカラム' do
      it '空欄でないこと' do
        item.item_name = ''
        expect(item.valid?).to eq false;
      end
    end
    context 'item_genreカラム' do
      it '空欄でないこと' do
        item.item_genre = ''
        expect(item.valid?).to eq false;
      end
    end
    context 'makerカラム' do
      it '空欄でないこと' do
        item.maker = ''
        expect(item.valid?).to eq false;
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Interestモデルとの関係' do
      it '1:Nとなっている' do
        expect(Item.reflect_on_association(:interests).macro).to eq :has_many
      end
    end
    context 'Reviewモデルとの関係' do
      it '1:Nとなっている' do
        expect(Item.reflect_on_association(:reviews).macro).to eq :has_many
      end
    end
  end
end
# アソシエーションのテスト
