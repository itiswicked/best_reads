class Api::V1::VotesController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :set_review

  def create_upvote
    upvote = @review.upvotes.build
    upvote.user = current_user
    if upvote.save
      upvotes = @review.upvotes.count
      render json: upvotes
    end
  end

  def create_downvote
    downvote = @review.downvotes.build
    downvote.user = current_user

    if downvote.save
      downvotes = @review.downvotes.count
      render json: downvotes
    end
  end

  def delete_upvote
    upvote = Upvote.where(user_id: current_user.id).first

    upvote.destroy
    redirect_to book_path(@review.book)
  end

  def delete_downvote
    downvote = Downvote.where(user_id: current_user.id).first

    downvote.destroy
    redirect_to book_path(@review.book)
  end

  private

  def set_review
    @review = Review.find(params[:review_id])
  end
end
