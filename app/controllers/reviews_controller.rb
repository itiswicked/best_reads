class ReviewsController < ApplicationController
  RATINGS = [1, 2, 3, 4, 5]

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
    @ratings_collection = RATINGS
  end

  def create
    @book = Book.find(params[:book_id])
    @review = Review.new(review_params)
    @ratings_collection = RATINGS

    @user = current_user
    @review.user = @user
    @review.book = @book

    if Review.where(user_id: @user.id, book_id: @book.id).any?
      flash[:notice] = "You've already written a review for this book."
      redirect_to book_path(@book)

    elsif @review.save
      flash[:success] = "Review added successfully!"
      redirect_to book_path(@book)
      ReviewMailer.new_review(@review).deliver_later
    else
      flash[:warning] = @review.errors.full_messages.join(', ')
      render :new
    end
  end

  def update
binding.pry
  end

  private

  def review_params
    params.require(:review).permit(
      :title,
      :body,
      :rating,
      :user_id
    )
  end
end
