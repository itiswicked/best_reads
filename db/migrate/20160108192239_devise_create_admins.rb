class DeviseCreateAdmins < ActiveRecord::Migration
  def self.up
    create_table :admins do |t|
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.integer  :sign_in_count, default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      t.timestamps
    end
  end

  def self.down
    drop_table :admins
  end
end
