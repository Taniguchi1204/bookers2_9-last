class BooksController < ApplicationController
  before_action :move_to_index, only:[:edit,:update,:destroy]

  def move_to_index
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def show
    @book = Book.find(params[:id])
    @comment = BookComment.new
  end

  def index
    @book = Book.new
    @books = Book.includes(:favorites).sort {|a,b| b.favorited_user.size <=> a.favorited_user.size}
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body,:rate)
  end

end
