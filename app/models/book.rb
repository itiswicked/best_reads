class Book < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_book_name,
    against: :title,
    using: {
      tsearch: {
        prefix: true
      }
    }

  belongs_to :author
  belongs_to :user
  belongs_to :genre
  has_many :reviews
  has_many :users

  # accepts_nested_attributes_for :author

  validates :title, presence: true
  validates :description, presence: true
  validates :year, presence: true, numericality: true

  def reviewed?(user)
    Review.where(user_id: user.id, book_id: id).any?
  end

  paginates_per 20
end
