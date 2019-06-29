# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :name
      t.text :memo
      t.references :commentable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
