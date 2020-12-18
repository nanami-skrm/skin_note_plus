require 'rails_helper'

  describe 'コメントのテスト'  do
    let(:user) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:tweet2) { create(:tweet, user: user2) }
    let!(:comment) { create(:comment, user: user, tweet: tweet2) }
    let!(:comment2) { create(:comment, user: user2, tweet: tweet2) }
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログインする'
    end
    describe 'つぶやき詳細ページのテスト' do
      context "投稿のテスト" do
        before do
          visit user_tweet_path(tweet2)
        end
        it '投稿に成功する' do
          fill_in 'comment[comment_text]', with: 'コメントしました'
          click_button '送信する'
          expect(page).to have_content 'コメントしました'
        end
        it '投稿に失敗する' do
          fill_in 'comment[comment_text]', with: ''
          click_button '送信する'
          expect(page).to have_content "コメントを入力してください"
        end
        it '自分の投稿の削除リンクが表示される' do
          expect(page).to have_link '削除', href: user_tweet_comment_path(tweet2, comment)
        end
        it '他人の投稿の削除リンクが表示されない' do
          expect(page).to have_no_link '削除', href: user_tweet_comment_path(tweet2, comment2)
        end
      end
    end
  end