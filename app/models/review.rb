class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_many :upvotes
  has_many :downvotes

  validates :body, length: { maximum: 500 }
  validates :rating, presence: true

  paginates_per 20

  def full_user_name
    "#{user.first_name.capitalize} #{user.last_name.chars.first.capitalize}"
  end

  def up_voted?(user)
    Upvote.where(user_id: user.id, review_id: id).any?
  end

  def down_voted?(user)
    Downvote.where(user_id: user.id, review_id: id).any?
  end

  def reviewed_by?(user)
    where(user_id: user.id, book_id: book.id).any?
  end
end
