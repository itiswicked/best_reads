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
end
