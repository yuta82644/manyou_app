require "rails_helper"

RSpec.describe "タスク管理機能", type: :system do
  describe "新規作成機能" do
    context "タスクを新規作成した場合" do
      it "作成したタスクが表示される" do
        task =
          FactoryBot.create(:task, title: "task", end_time: Time.now + 1.day)
        visit tasks_path
        expect(page).to have_content "task"
      end
    end
  end

  describe "一覧表示機能" do
    context "一覧画面に遷移した場合" do
      it "作成済みのタスク一覧が表示される" do
        task1 =
          FactoryBot.create(:task, title: "task01", end_time: Time.now + 2.days)
        task2 =
          FactoryBot.create(:task, title: "task02", end_time: Time.now + 3.days)
        visit tasks_path
        expect(page).to have_content "task01"
        expect(page).to have_content "task02"
      end
    end
  end

  describe "詳細表示機能" do
    context "任意のタスク詳細画面に遷移した場合" do
      it "該当タスクの内容が表示される" do
        task =
          FactoryBot.create(:task, title: "task", end_time: Time.now + 4.days)
        visit task_path(task)
        expect(page).to have_content "task"
      end
    end

    context "タスクが作成日時の降順に並んでいる場合" do
      it "新しいタスクが一番上に表示される" do
        task1 =
          FactoryBot.create(
            :task,
            title: "task1",
            created_at: Time.now,
            end_time: Time.now + 5.days,
          )
        task2 =
          FactoryBot.create(
            :task,
            title: "task2",
            created_at: Time.now - 1.day,
            end_time: Time.now + 6.days,
          )
        visit tasks_path
        task_rows = page.all(".task_row")
        expect(task_rows[0]).to have_content task1.title
      end
    end
  end

  describe "検索機能" do
    before do
      FactoryBot.create(:task, title: "task", status: "未着手")
      FactoryBot.create(:task, title: "sample", status: "完了")
    end
    context "タイトルであいまい検索をした場合" do
      it "検索キーワードを含むタスクで絞り込まれる" do
        task1 = FactoryBot.create(:task, title: "ねこ")
        task2 = FactoryBot.create(:task, title: "犬")
        task3 = FactoryBot.create(:task, title: "鳥")
        visit tasks_path
        sleep(3)
        fill_in "task[title]", with: "ねこ"
        click_on "検索"
        expect(page).to have_content task1.title
        expect(page).not_to have_content task2.title
        expect(page).not_to have_content task3.title
      end
    end

    context "ステータス検索をした場合" do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        task1 = FactoryBot.create(:task, status: 0)
        task2 = FactoryBot.create(:task, status: 1)
        task3 = FactoryBot.create(:task, status: 2)
        visit tasks_path
        select "未着手", from: "task[status]"
        click_on "検索"
        sleep(3)
        expect(page).to have_content task3.title
        # ここに実装する
        # プルダウンを選択する「select」について調べてみること
      end
    end
    context "タイトルのあいまい検索とステータス検索をした場合" do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        task1 = FactoryBot.create(:task, title: "いぬ")
        task2 = FactoryBot.create(:task, title: "ねこ")
        task3 = FactoryBot.create(:task, title: "とり")
        task4 = FactoryBot.create(:task, status: 0)
        task5 = FactoryBot.create(:task, status: 1)
        task6 = FactoryBot.create(:task, status: 2)
        visit tasks_path
        fill_in "task[title]", with: "いぬ"
        select "未着手", from: "task[status]"
        click_on "検索"
        expect(page).to have_content task1.title
        expect(page).to have_content task4.status
        expect(page).not_to have_content task2.title
        # ここに実装する
      end
    end
  end
end
