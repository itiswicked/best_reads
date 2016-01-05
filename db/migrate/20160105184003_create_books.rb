class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :year, null: false
      t.integer :genre_id, null: false
      t.integer :author_id, null: false

      t.timestamps null: false
    end
  end
end
