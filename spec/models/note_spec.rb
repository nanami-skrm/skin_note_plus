require 'rails_helper'

RSpec.describe 'Noteモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:note) { build(:note, user_id: user.id) }

    context 'dateカラム' do
      it '空欄でないこと' do
        note.date = ''
        expect(note.valid?).to eq false;
      end
    end
    context 'conditionカラム' do
      it '空欄でないこと' do
        note.condition = ''
        expect(note.valid?).to eq false;
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'TodaysItemモデルとの関係' do
      it '1:Nとなっている' do
        expect(Note.reflect_on_association(:todays_items).macro).to eq :has_many
      end
    end
    context 'MYItemモデルとの関係' do
      it '1:Nとなっている' do
        expect(Note.reflect_on_association(:my_items).macro).to eq :has_many
      end
    end
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Note.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
# アソシエーションのテスト
