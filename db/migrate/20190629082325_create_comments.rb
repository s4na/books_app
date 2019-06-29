class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.reference{polymorphic} :commentable
      t.string :name
      t.text :memo

      t.timestamps
    end
  end
end
