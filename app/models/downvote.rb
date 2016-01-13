class Downvote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates_uniqueness_of :user_id, scope: :review_id
  # validate :already_voted_up
  #
  # def already_voted_up
  #   errors.add("You have already voted!") if Upvote.where(user_id: user.id).exists?
  # end

end
