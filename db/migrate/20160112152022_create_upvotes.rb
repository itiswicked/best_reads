class CreateUpvotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :review, index: true, foreign_key: true
    end
  end
end
