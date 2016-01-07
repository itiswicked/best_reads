class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 500 }
  validates :rating, presence: true
  # validates :book_id, uniqueness: { scope: :user_id, message: "You've reviewed this book!" }
end
