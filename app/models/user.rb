class User < ActiveRecord::Base
  mount_uploader :profile_photo, ProfilePhotoUploader

  has_many :books
  has_many :reviews

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_user_name
    "#{first_name.capitalize} #{last_name.chars.first.capitalize}"
  end

  def admin?
    role == "admin"
  end
end
