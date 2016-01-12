class Author < ActiveRecord::Base
  include PgSearch
  multisearchable :against => :name

  has_many :books
  has_many :genres, through: :books
  accepts_nested_attributes_for :books

  validates :name, presence: true
end
