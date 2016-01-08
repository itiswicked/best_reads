class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  validates :body, length: { maximum: 500 }
  validates :rating, presence: true
end
