class Book < ActiveRecord::Base
  include PgSearch
  multisearchable against: [
    :title,
    :description
  ]

  belongs_to :author
  belongs_to :user
  belongs_to :genre
  has_many :reviews
  has_many :users

  accepts_nested_attributes_for :author

  validates :title, presence: true
  validates :description, presence: true
  validates :year, presence: true, numericality: true

  paginates_per 20
end
