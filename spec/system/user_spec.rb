require "rails_helper"
RSpec.describe "ユーザー管理", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:admin_user) }

  describe "ユーザー登録" do
    context "新規登録画面に移動" do
      it "ユーザー登録される" do
        visit new_user_path
        fill_in "user_name", with: "takayu"
        fill_in "user_email", with: "4444@dic.com"
        fill_in "user_password", with: "111111"
        fill_in "user_password_confirmation", with: "111111"
        click_on "Create my account"
        expect(page).to have_content "takayu"
        expect(page).to have_content "4444@dic.com"
      end
    end

    context "ログインせずタスク一覧画面に飛ぼうとした時" do
      it "ログイン画面に遷移すること" do
        visit tasks_path
        expect(page).to have_css("h1", text: "Login") #sessiotn/newのh1 login表示の確認
      end
    end
  end

  describe "セッション機能のテスト" do
    context "ログインした場合" do
      it "詳細画面に遷移する" do
        visit new_session_path
        fill_in "session_email", with: user.email
        fill_in "session_password", with: user.password
        click_on "Log in"
        visit user_path(user)
        expect(current_path).to eq user_path(user)
      end
    end

    context "一般ユーザーが他人の詳細画面に飛ぶ時" do
      it "タスク一覧画面に遷移" do
        visit new_session_path
        fill_in "session_email", with: user.email
        fill_in "session_password", with: user.password
        click_on "Log in"
        visit user_path(admin_user)
        expect(current_path).to eq tasks_path
      end
    end

    context "ログイン後" do
      it "ログアウトができる" do
        visit new_session_path
        fill_in "session_email", with: user.email
        fill_in "session_password", with: user.password
        click_on "Log in"
        visit user_path(user)
        click_link "Logout"
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe "管理画面のテスト" do
    context "管理ユーザーがログインした場合" do
      it "管理画面に遷移できる" do
        visit new_session_path
        sleep(3)
        fill_in "session_email", with: "admin@dic.com"
        fill_in "session_password", with: "222222"
        sleep(3)
        click_on "Log in"
        sleep(3)
        visit admin_users_path
        sleep(3)
        expect(current_path).to eq admin_users_path
        sleep(3)
      end
    end
    context "管理ユーザが編集画面からユーザを編集した場合" do
      it "ユーザの情報が変更される" do
        visit new_session_path
        fill_in "session_email", with: "admin@dic.com"
        sleep(3)
        fill_in "session_password", with: "222222"
        sleep(3)
        click_on "Log in"
        sleep(3)
        visit admin_users_path
        visit edit_admin_user_path(user)
        sleep(3)
        fill_in "user_password", with: "111111"
        fill_in "user_password_confirmation", with: "111111"
        click_on "登録"
        sleep(3)
        visit admin_users_path
        expect(page).to have_content user.name
      end
    end
    
    context "管理ユーザがユーザを削除した場合" do
      it "ユーザ一覧画面にそのユーザが表示されない" do
        sleep(3)
        visit new_session_path
        fill_in "session_email", with: "admin@dic.com"
        sleep(3)
        fill_in "session_password", with: "222222"
        sleep(3)
        click_on "Log in"
        sleep(3)
        visit admin_users_path
        sleep(3)
        click_on "削除", match: :first
        sleep(3)
        expect(page).to have_content "ユーザーを削除しました"
        sleep(3)
      end
    end
  end
end
