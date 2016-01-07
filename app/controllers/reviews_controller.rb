class ReviewsController < ApplicationController
  # def index
  #   @reviews = Review.all
  # end
  #
  # def show
  #   @book = Book.find(params[:id])
  #   @reviews = @book.reviews
  # end

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    @book = Book.find(params[:book_id])
    @review = Review.new(review_params)

    if @review.save
      flash[:notice] = "Review added successfully"
      redirect_to book_path(@book), alert: "Review Added Successfully"
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
