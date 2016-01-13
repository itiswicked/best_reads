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

  def create_upvote
    review = Review.find(params[:review_id])
    upvote = Upvote.new(review_id: review.id, user_id: current_user.id)

    # respond_to do |format|
      if upvote.save
        redirect_to book_path(review.book)
    #     format.html { redirect_to book_path(review.book) }
    #     format.js { render json: { upvotes_count: review.upvotes.count } }
        # redirect_to book_path(review.book)
      end
    # end
  end

  def create_downvote
    review = Review.find(params[:review_id])
    downvote = Downvote.new(review_id: review.id, user_id: current_user.id)

    # respond_to do |format|
      if downvote.save
        redirect_to book_path(review.book)
    #     format.html { redirect_to book_path(review.book) }
    #     format.js { render json: { downvotes_count: review.downvotes.count } }
      end
    # end
  end

  def delete_upvote
    @review = Review.find(params[:review_id])
    # binding.pry
    @upvote = Upvote.where(user_id: current_user.id).first

    @upvote.destroy
    redirect_to book_path(@review.book)
  end

  def delete_downvote
    @review = Review.find(params[:review_id])
    @downvote = Downvote.where(user_id: current_user.id).first

    @downvote.destroy
    redirect_to book_path(@review.book)
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
