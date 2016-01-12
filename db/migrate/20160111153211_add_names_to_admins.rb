class AddNamesToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :first_name, :string, null: false
    add_column :admins, :last_name, :string, null: false
  end
end
