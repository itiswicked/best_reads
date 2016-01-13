class BooksController < ApplicationController
  helper_method :reviewed?
  before_action :authorize_user, except: [:index, :show]

  def index
    @books = Book.order(:title).page params[:page]
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews.order(created_at: :asc).page params[:page]
  end

  def new
    @book = Book.new
    @author = Author.new
    @genres_collection = genres_collection
  end

  def create
    @book = Book.new(book_params)
    @genres_collection = genres_collection

    @author = Author.find_or_create_by(name: author_params[:author])

    @book.author = @author

    @user = current_user

    @book.user = @user

    if @book.save
      flash[:success] = "Book added successfully!"
      redirect_to books_path
    else
      flash[:warning] = @book.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
    @genres_collection = genres_collection
  end

  def update
    @genres_collection = genres_collection
    @book = Book.find(params[:id])
    @author = Author.find_by(name: author_params[:author])

    @book.author = @author
    @user = current_user

    @book.user = @user
    @book.update(book_params)

    if @book.save
      redirect_to book_path(@book)
    else
      flash[:errors] = @book.errors.full_messages.join(". ")
      render action: 'new'
    end
  end

  private

  def book_params
    params.require(:book).permit(
      :title,
      :description,
      :year,
      :genre_id,
      :author_id,
      :user_id
    )
  end

  def author_params
    params.require(:book).permit(:author)
  end

  def genres_collection
    Genre.all.map { |genre| [genre.genre_name, genre.id] }
  end

  def authorize_user
  if !user_signed_in? || !current_user.admin?
    raise ActionController::RoutingError.new("Not Found")
  end
end
end
