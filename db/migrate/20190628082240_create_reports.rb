class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.string :title
      t.string :emotion
      t.text :body
      t.string :author
      t.datetime :datetime

      t.timestamps
    end
  end
end
