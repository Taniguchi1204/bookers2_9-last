class BooksController < ApplicationController
  before_action :move_to_index, only:[:edit,:update,:destroy]

  def book_count(num)

  end

  def move_to_index
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def show
    @book = Book.find(params[:id])
    @comment = BookComment.new
    unless Viewcount.find_by(user_id: current_user,book_id: @book.id)
      current_user.viewcounts.create(book_id: @book.id)
    end
  end

  def index
    @book = Book.new
    @books = Book.includes(:favorites).sort {|a,b| b.favorited_user.size <=> a.favorited_user.size}
    @a = Book.where(created_at: Date.today.all_day).count
    @b = Book.where(created_at: Date.today.days_ago(1).all_day).count
    @c = Book.where(created_at: Date.today.days_ago(2).all_day).count
    @d = Book.where(created_at: Date.today.days_ago(3).all_day).count
    @e = Book.where(created_at: Date.today.days_ago(4).all_day).count
    @f = Book.where(created_at: Date.today.days_ago(5).all_day).count
    @g = Book.where(created_at: Date.today.days_ago(6).all_day).count
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

  def search
    @book = Book.new
    @books = Book.all.order(created_at: :desc)
    @a = Book.where(created_at: Date.today.all_day).count
    @b = Book.where(created_at: Date.today.days_ago(1).all_day).count
    @c = Book.where(created_at: Date.today.days_ago(2).all_day).count
    @d = Book.where(created_at: Date.today.days_ago(3).all_day).count
    @e = Book.where(created_at: Date.today.days_ago(4).all_day).count
    @f = Book.where(created_at: Date.today.days_ago(5).all_day).count
    @g = Book.where(created_at: Date.today.days_ago(6).all_day).count
  end

  def rate
    @book = Book.new
    @books = Book.all.order(rate: :desc)
    @a = Book.where(created_at: Date.today.all_day).count
    @b = Book.where(created_at: Date.today.days_ago(1).all_day).count
    @c = Book.where(created_at: Date.today.days_ago(2).all_day).count
    @d = Book.where(created_at: Date.today.days_ago(3).all_day).count
    @e = Book.where(created_at: Date.today.days_ago(4).all_day).count
    @f = Book.where(created_at: Date.today.days_ago(5).all_day).count
    @g = Book.where(created_at: Date.today.days_ago(6).all_day).count
  end



  private

  def book_params
    params.require(:book).permit(:title,:body,:category,:rate)
  end

end
