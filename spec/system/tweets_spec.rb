require 'rails_helper'

  describe 'つぶやきのテスト' do
    let(:user) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:tweet) { create(:tweet, user: user) }
    let!(:tweet2) { create(:tweet, user: user2) }
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログインする'
      visit user_tweets_path
    end
    describe 'つぶやき一覧ページのテスト' do
      context "表示の確認" do
        it 'みんなのつぶやき一覧と表示される' do
          expect(page).to have_content 'みんなのつぶやき一覧'
        end
      end
      context "投稿のテスト" do
        it '投稿に成功する' do
          fill_in 'tweet[tweet_text]', with: 'つぶやきました'
          click_button '投稿する'
          expect(page).to have_content 'つぶやきました'
        end
        it '投稿に失敗する' do
          fill_in 'tweet[tweet_text]', with: ''
          click_button '投稿する'
          expect(page).to have_content 'error'
        end
        it '自分の投稿の削除リンクが表示される' do
          expect(page).to have_link '削除', href: user_tweet_path(tweet)
        end
        it '他人の投稿の削除リンクが表示されない' do
          expect(page).to have_no_link '削除', href: user_tweet_path(tweet2)
        end
      end
    end

  end


