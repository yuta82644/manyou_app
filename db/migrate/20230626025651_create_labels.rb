class CreateLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :labels do |t|
      t.string :label_name, null: false

      t.timestamps
    end
  end
end
