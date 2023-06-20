FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    status { '未着手' }
    end_time { Time.current + 1.day } # 1日後の日時を設定
  end

  factory :second_task, class: Task do
    title { 'Factotで作ったデフォルトのタイトル2' }
    content { 'Factoyで作ったデフォルトのコンテンツ2' }
    status { '完了' }
    end_time { Time.current + 2.days } # 2日後の日時を設定
  end
end
