class Task < ApplicationRecord
  validates :title, :content, presence: true
  # default_scope -> { order(created_at: :desc)}
  enum status: { "未着手": 0, "着手中": 1, "完了": 2 }
  enum priority: { "低": 0, "中": 1, "高": 2 }
  scope :title_search, ->(title) { where("title LIKE ?", "%#{title}%") }
  scope :status_search, ->(status) { where(status: status) }
  belongs_to :user
end
