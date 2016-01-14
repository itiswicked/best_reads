class SearchController < ApplicationController
  def index
    if params[:query]
      @books = Book.search_by_book_name(params[:query])
    end
  end
end
