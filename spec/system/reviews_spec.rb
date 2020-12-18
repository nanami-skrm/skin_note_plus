require 'rails_helper'

  describe 'レビューのテスト', :js => true  do
    let(:admin) { create(:admin) }
    let(:item) { create(:item) }
    let(:user) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:review) { create(:review, user: user, item: item) }
    let!(:review2) { create(:review, user: user2, item: item) }
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログインする'
    end
    describe 'アイテム詳細ページのテスト' do
      context "投稿のテスト" do
        before do
          visit user_item_path(item)
          sleep 0.1
        end
        it '投稿に成功する' do
          page.all('#star img')[3].click
          fill_in 'review[review_text]', with: 'レビューしました'
          click_button '投稿する'
          expect(page).to have_content 'レビューしました'
        end
        it '投稿に失敗する' do
          fill_in 'review[review_text]', with: ''
          click_button '投稿する'
          expect(page).to have_content "評価を入力してください"
          expect(page).to have_content "口コミ内容を入力してください"
        end
        it '自分の投稿の削除リンクが表示される' do
          expect(page).to have_link '削除', href: user_item_review_path(item,review)
        end
        it '他人の投稿の削除リンクが表示されない' do
          expect(page).to have_no_link '削除', href: user_item_review_path(item,review2)
        end
      end
    end
  end
