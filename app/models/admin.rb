class Admin < ActiveRecord::Base
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
end
