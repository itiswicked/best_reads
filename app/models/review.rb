class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_many :votes

  validates :body, length: { maximum: 500 }
  validates :rating, presence: true

  paginates_per 20

  def full_user_name
    "#{user.first_name.capitalize} #{user.last_name.chars.first.capitalize}"
  end

  def reviewed_by?(user)
    where(user_id: user.id, book_id: book.id).any?
  end

  def score
    Vote.where(review_id: id).sum(:vote)
  end
end
