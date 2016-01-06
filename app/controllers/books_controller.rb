class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    # @reviews = @book.reviews
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

    if @book.save
      flash[:notice] = "Book added successfully"
      redirect_to books_path, alert: "Book Added Successfully"
    else
      flash[:notice] = "Book not created"
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit(:title,
                                 :description,
                                 :year,
                                 :genre_id,
                                 :author_id)
  end

  def author_params
    params.require(:book).permit(:author)
  end

  def genres_collection
    Genre.all.map { |genre| [genre.genre_name, genre.id] }
  end
end
