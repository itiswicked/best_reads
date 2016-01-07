class AddUserIdToBooksTable < ActiveRecord::Migration
  def up
    add_column :books, :user_id, :integer, null: false
 end

  def down
    remove_column :books, :user_id
  end
end
