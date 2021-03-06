class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :year, null: false
      t.belongs_to :genre, null: false
      t.belongs_to :author, null: false

      t.timestamps null: false
    end
  end
end
