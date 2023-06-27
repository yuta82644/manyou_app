require "rails_helper"
RSpec.describe "ラベル検索機能", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:label) { FactoryBot.create(:label) }

  def login
    visit new_session_path
    fill_in "session_email", with: user.email
    fill_in "session_password", with: user.password
    click_on "Log in"
    # expect(current_path).to eq user_path(user)
  end
  sleep(3)

  describe "ラベル登録" do
    before { login }
    sleep(3)

    context "タスクを新規登録した場合" do
      it "ラベル登録がされる" do
        task = FactoryBot.create(:task, user_id: user.id)

        visit new_task_path
        fill_in "task[title]", with: "title"
        fill_in "task[content]", with: "content"
        fill_in "task[end_time]", with: "002023-06-30"
        select "未着手", from: "task[status]"
        select "高", from: "task[priority]"
        check "LABEL"
        click_on "登録"

        expect(page).to have_content "title"
        expect(page).to have_content "content"
        expect(page).to have_content "LABEL"
      end
    end
    context "絞り込み検索でラベルを選択した場合" do
      it "ラベル検索できる" do
        visit new_task_path
        fill_in "task[title]", with: "title"
        fill_in "task[content]", with: "content"
        fill_in "task[end_time]", with: "002023-6-30"
        select "未着手", from: "task[status]"
        select "高", from: "task[priority]"
        check "LABEL"
        click_on "登録する"
        select "LABEL", from: "task[label_ids]"
        click_on "検索"
        expect(page).to have_content "LABEL"
      end
    end

    context "詳細画面押した場合" do
      it "詳細画面でラベルが表示される" do
        visit new_task_path
        fill_in "task[title]", with: "title"
        sleep(3)
        fill_in "task[content]", with: "content"
        fill_in "task[end_time]", with: "002023-6-30"
        select "未着手", from: "task[status]"
        select "高", from: "task[priority]"
        check "LABEL"
        sleep(3)
        click_on "登録"
        sleep(3)
        select "LABEL", from: "task[label_ids]"
        click_link "show"
        sleep(3)
        
        expect(page).to have_content "title"
        expect(page).to have_content "content"
        expect(page).to have_content "LABEL"
      end
    end
  end
end
