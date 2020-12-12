require 'rails_helper'

  describe 'アイテムのテスト' do
    let(:admin) { create(:admin) }
    let(:user) { create(:user) }
    let!(:item) { create(:item) }
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログインする'
      visit user_items_path
    end
    describe 'アイテム一覧ページのテスト' do
      context "表示の確認" do
        it '口コミランキングと表示される' do
          expect(page).to have_content '口コミランキング'
        end
      end
    end
    describe 'アイテム詳細ページのテスト' do
      # context 'アイテム詳細ページへの遷移' do
      #   it '遷移できる' do
      #     visit user_item_path(item)
      #     expect(page).to eq('/user/items/' + item.id.to_s)
      #   end
      # end
      before do
        visit user_item_path(item)
      end
      context "表示の確認" do
        it 'この商品の口コミと表示される' do
          expect(page).to have_content 'この商品の口コミ'
        end
        it '商品名が表示される' do
          expect(page).to have_content(item.item_name)
        end
        it 'メーカーが表示される' do
          expect(page).to have_content(item.maker)
        end
        it '商品ジャンルが表示される' do
          expect(page).to have_content(item.item_genre)
        end
        it '評価の平均値が表示される' do
          expect(page).to have_content(item.reviews.average(:score).to_f.round(1))
          #reviewある状態じゃないと意味ない
        end
      end
    end
  end
