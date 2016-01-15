class Vote < ActiveRecord::Base
  belongs_to :review
  belongs_to :user

  validates :review, presence: true, uniqueness: { scope: :user }
  validates :user, presence: true, uniqueness: { scope: :review }
  validates :vote, numericality: true, inclusion: { in: -1..1 }
end
