class Upvote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates_uniqueness_of :user_id, scope: :review_id
  # validate :already_voted_down
  #
  # def already_voted_down
  #   errors.add("You have already voted!") if Downvote.where(user_id: user.id).exists?
  # end
end
