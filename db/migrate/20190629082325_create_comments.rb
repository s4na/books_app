# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      # t.reference{polymorphic} :commentable, index: true
      t.references :commentable, polymorphic: true, index: true
      t.string :name
      t.text :memo

      t.timestamps
    end
  end
end
