require 'rails_helper'

  describe 'レビューのテスト', :js => true  do
    let(:admin) { create(:admin) }
    let(:item) { create(:item) }
    let(:user) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:review) { create(:review, user: user, item:item) }
    let!(:review2) { create(:review, user: user2, item:item) }
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
          expect(page).to have_content "Score can't be blank"
          expect(page).to have_content "Review text can't be blank"
        end
        it '自分の投稿の削除リンクが表示される' do
          expect(page).to have_link '削除', href: user_item_review_path(item,review)
        end
        it '他人の投稿の削除リンクが表示されない' do
          expect(page).to have_no_link '削除', href:  user_item_review_path(item,review2)
        end
      end
     end
  end

    #   context "表示の確認" do
    #     it '口コミランキングと表示される' do
    #       expect(page).to have_content '口コミランキング'
    #     end
    #   end
    # end
    # describe 'アイテム詳細ページのテスト' do
    #   # context 'アイテム詳細ページへの遷移' do
    #   #   it '遷移できる' do
    #   #     visit user_item_path(item)
    #   #     expect(page).to eq('/user/items/' + item.id.to_s)
    #   #   end
    #   # end
    #   before do
    #     visit user_item_path(item)
    #   end
    #   context "表示の確認" do
    #     it 'この商品の口コミと表示される' do
    #       expect(page).to have_content 'この商品の口コミ'
    #     end
    #     it '商品名が表示される' do
    #       expect(page).to have_content(item.item_name)
    #     end
    #     it 'メーカーが表示される' do
    #       expect(page).to have_content(item.maker)
    #     end
    #     it '商品ジャンルが表示される' do
    #       expect(page).to have_content(item.item_genre)
    #     end
    #     it '評価の平均値が表示される' do
    #       expect(page).to have_content(item.reviews.average(:score).to_f.round(1))
    #       #reviewある状態じゃないと意味ない
    #     end

