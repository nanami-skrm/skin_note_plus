require 'rails_helper'

  describe 'マイアイテムのテスト' do
    let(:user) { create(:user) }
    let!(:my_item) { create(:my_item, user: user) }
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログインする'
      visit user_my_items_path
    end
    describe 'マイスキンケア一覧ページのテスト' do
      context "表示の確認" do
        it 'マイスキンケア一覧と表示される' do
          expect(page).to have_content 'マイスキンケア一覧'
        end
        it 'マイスキンケア登録と表示される' do
          expect(page).to have_content 'マイスキンケア登録'
        end
      end
      context "投稿のテスト" do
        it '投稿に成功する' do
          fill_in 'my_item[item_name]', with: '商品の名前'
          fill_in 'my_item[maker]', with: '会社の名前'
          click_button '登録する'
          expect(page).to have_content '商品の名前'
          expect(page).to have_content '会社の名前'
        end
        it '投稿に失敗する' do
          fill_in 'my_item[item_name]', with: ''
          fill_in 'my_item[maker]', with: ''
          click_button '登録する'
          expect(page).to have_content "商品名を入力してください"
          expect(page).to have_content "メーカーを入力してください"
        end
        it '削除リンクが表示される' do
          expect(page).to have_link '削除', href: user_my_item_path(my_item)
        end
      end
    end
  end