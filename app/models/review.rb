class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_many :upvotes
  has_many :downvotes

  validates :body, length: { maximum: 500 }
  validates :rating, presence: true

  def full_user_name
    "#{user.first_name.capitalize} #{user.last_name.chars.first.capitalize}"
  end
end
