require "rails_helper"

RSpec.describe "タスク管理機能", type: :system do
  describe "新規作成機能" do
    context "タスクを新規作成した場合" do
      it "作成したタスクが表示される" do
        task = FactoryBot.create(:task, title: "task", end_time: Time.now + 1.day)
        visit tasks_path
        expect(page).to have_content "task"
      end
    end
  end

  describe "一覧表示機能" do
    context "一覧画面に遷移した場合" do
      it "作成済みのタスク一覧が表示される" do
        task1 = FactoryBot.create(:task, title: "task01", end_time: Time.now + 2.days)
        task2 = FactoryBot.create(:task, title: "task02", end_time: Time.now + 3.days)
        visit tasks_path
        expect(page).to have_content "task01"
        expect(page).to have_content "task02"
      end
    end
  end

  describe "詳細表示機能" do
    context "任意のタスク詳細画面に遷移した場合" do
      it "該当タスクの内容が表示される" do
        task = FactoryBot.create(:task, title: "task", end_time: Time.now + 4.days)
        visit task_path(task)
        expect(page).to have_content "task"
      end
    end

    context "タスクが作成日時の降順に並んでいる場合" do
      it "新しいタスクが一番上に表示される" do
        task1 = FactoryBot.create(:task, title: "task1", created_at: Time.now, end_time: Time.now + 5.days)
        task2 = FactoryBot.create(:task, title: "task2", created_at: Time.now - 1.day, end_time: Time.now + 6.days)
        visit tasks_path
        task_rows = page.all(".task_row")
        expect(task_rows[0]).to have_content task1.title
      end
    end
  end
end
