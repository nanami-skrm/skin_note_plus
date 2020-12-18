require 'rails_helper'

describe 'ユーザー認証のテスト' do
  describe 'ユーザー新規登録' do
    before do
      visit new_user_registration_path
    end
    context '新規登録画面に遷移' do
      it '新規登録に成功する' do
        fill_in 'user[name]', with: Faker::Internet.username(specifier: 5..10)
        fill_in 'user[age]', with: 20
        select '乾燥肌', from: 'user[skin_type]'
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '登録する'

        expect(page).to have_content 'ログアウト'
      end
      it '新規登録に失敗する' do
        fill_in 'user[name]', with: ''
        fill_in 'user[age]', with: ''
        select '乾燥肌', from: 'user[skin_type]'
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button '登録する'

        expect(page).to have_content 'メールアドレスを入力してください'
        expect(page).to have_content 'パスワードを入力してください'
        expect(page).to have_content 'ユーザ名を入力してください'
        expect(page).to have_content 'ユーザ名は2文字以上で入力してください'
        expect(page).to have_content '年齢を入力してください'
      end
    end
  end
  describe 'ユーザーログイン' do
    let(:user) { create(:user) }
    before do
      visit new_user_session_path
    end
    context 'ログイン画面に遷移' do
      let(:test_user) { user }
      it 'ログインに成功する' do
        fill_in 'user[email]', with: test_user.email
        fill_in 'user[password]', with: test_user.password
        click_button 'ログインする'

        expect(page).to have_content 'ログアウト'
      end
      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログインする'

        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
end

describe 'ユーザーのテスト' do
  let(:user) { create(:user) }
  let!(:test_user2) { create(:user) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログインする'
  end
  describe 'マイページのテスト' do
    context '表示の確認' do
      it 'こんにちはと表示される' do
        expect(page).to have_content('こんにちは')
      end
      it '画像が表示される' do
        expect(page).to have_css('img.image')
      end
      it '名前が表示される' do
        expect(page).to have_content(user.name)
      end
      it '年齢が表示される' do
        expect(page).to have_content(user.age)
      end
      it '肌質が表示される' do
        expect(page).to have_content(user.skin_type)
      end
      # it '当月のデータが表示される' do
      #   expect(page).to have_content('#{Date.today.month.to_i}月')
      # end
      it '編集リンクが表示される' do
        expect(page).to have_link '', href: edit_user_user_path(user)
      end
    end
  end

  describe '編集のテスト' do
    context '自分の編集画面への遷移' do
      it '遷移できる' do
        visit edit_user_user_path(user)
        expect(current_path).to eq('/user/users/' + user.id.to_s + '/edit')
      end
    end
    context '他人の編集画面への遷移' do
      it '遷移できない' do
        visit edit_user_user_path(test_user2)
        expect(current_path).to eq('/user/users/' + user.id.to_s + '/edit')
      end
    end
    context '表示の確認' do
      before do
        visit edit_user_user_path(user)
      end
      it '登録情報変更と表示される' do
        expect(page).to have_content '登録情報変更'
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[image]'
      end
      it '年齢編集フォームに自分の年齢が表示される' do
        expect(page).to have_field 'user[age]', with: user.age
      end
      it '編集に成功する' do
        click_button '変更する'
        expect(page).to have_content 'こんにちは'
      end
      it '編集に失敗する' do
        fill_in 'user[name]', with: ''
        click_button '変更する'
        expect(page).to have_content 'ユーザ名を入力してください'
        expect(page).to have_content 'ユーザ名は2文字以上で入力してください'
        expect(current_path).to eq('/user/users/' + user.id.to_s)
      end
    end
  end
end
