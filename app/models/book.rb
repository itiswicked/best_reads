class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :user
  belongs_to :genre
  has_many :reviews
  has_many :users

  accepts_nested_attributes_for :author

  validates :title, presence: true
  validates :description, presence: true
  validates :year, presence: true, numericality: true

  def reviewed?(user)
    Review.where(user_id: user.id, book_id: id).any?
  end
end
