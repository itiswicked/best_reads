class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  validates :body, length: { maximum: 500 }
  validates :rating, presence: true

  def full_user_name
    "#{user.first_name.capitalize} #{user.last_name.chars.first.capitalize}"
  end

  def reviewed_by?(user)
    where(user_id: user.id, book_id: book.id).any?
  end
end
