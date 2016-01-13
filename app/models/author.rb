class Author < ActiveRecord::Base
  has_many :books
  has_many :genres, through: :books
  accepts_nested_attributes_for :books

  validates :name, presence: {message: "Author cannot be blank"}

end
