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

    @user = User.find_by(params[:id])
    @review.user = @user
    @review.book = @book

    if Review.where(user_id: @user.id, book_id: @book.id).any?
      redirect_to book_path(@book)

      flash[:notice] = "You've already written a review for this book."

    elsif @review.save
      flash[:notice] = "Review added successfully"
      redirect_to book_path(@book)
    else
      flash[:notice] = "Review not created"
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:title,
                                   :body,
                                   :rating,
                                   :user_id
                                  )
  end
end
