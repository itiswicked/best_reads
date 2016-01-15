class VotesController < ApplicationController
  before_action :review_and_value

  def upvote
    if @value.vote == 0 || @value.vote == -1
      @value.vote = 1
      @value.save
      flash[:notice] = "Upvoted!"
    elsif @value.vote == 1
      @value.vote -= 1
      @value.save
      flash[:notice] = "Upvote cancelled!"
    end
    redirect_to book_path(@review.book)
  end

  def downvote
    if @value.vote == 0 || @value.vote == 1
      @value.vote = -1
      @value.save
      VoteMailer.down_vote(@review).deliver_later
      flash[:notice] = "Downvoted!"
    elsif @value.vote == -1
      @value.vote += 1
      @value.save
      flash[:notice] = "Downvote cancelled!"
    end
    redirect_to book_path(@review.book)
  end

  private

  def review_and_value
    @review = Review.find(params[:review_id])
    @value = Vote.find_or_initialize_by(review: @review, user: current_user)
  end
end
