class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :user
  belongs_to :genre
  has_many :reviews

  accepts_nested_attributes_for :author

  validates :title, presence: true
  validates :description, presence: true
  validates :year, presence: true
end
