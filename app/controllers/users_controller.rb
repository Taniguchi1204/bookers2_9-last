class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]
  before_action :move_to_index, only:[:edit,:update,:destroy]


  def move_to_index
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.all
    @books_tody = @user.books.where(created_at: Date.today.all_day)
    @books_before = @user.books.where(created_at: Date.yesterday.all_day)
    @week = @user.books.where(created_at: Date.today.all_week).count
    @privous_week = @user.books.where(created_at: 1.week.ago.all_day).count
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @books = current_user.books.all
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
