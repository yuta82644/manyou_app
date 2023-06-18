class AddEndsToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :end_time, :datetime, null: false
  end
end
