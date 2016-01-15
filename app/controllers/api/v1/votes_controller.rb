class Api::V1::VotesController < ActionController::Base
  def upvote
    review = Review.find(params[:review][:id])
    value = Vote.find_or_initialize_by(review: review, user: current_user)

    (value.vote == 0 || value.vote == -1) ? value.vote = 1 : value.vote -= 1
    value.save
    score = Vote.group(:review_id).sum(:vote).values.first
    render json: score
  end

  def downvote
    review = Review.find(params[:review][:id])
    value = Vote.find_or_initialize_by(review: review, user: current_user)

    (value.vote == 0 || value.vote == 1) ? value.vote = -1 : value.vote += 1
    value.save
    score = Vote.group(:review_id).sum(:vote).values.first
    render json: score
  end

  private

  def vote_params
    params.require(:vote).permit(:user, :review)
  end
end
