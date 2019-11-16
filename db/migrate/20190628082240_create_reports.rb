# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[6.0]
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
