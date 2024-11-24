class BooksController < ApplicationController
  def index
    # TODO: paginate and filter
    @books = Book.all
  end

  def create
    @book = Book.create(book_params)
    # TODO: replace with book_path(@book)
    redirect_to books_path
  end

  def new
  end

  private

  def search_params
    params.fetch(:search_params, {}).permit(:name, :isbn)
  end

  def book_params
    params.require(:book).permit(:name, :description, :isbn)
  end
end
