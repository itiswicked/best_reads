class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title, null: false
      t.text :body
      t.integer :rating, null: false
      t.integer :votes, default: 0
      t.belongs_to :user, null: false, index: true, foreign_key: true
      t.belongs_to :book, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
