class SearchsController < ApplicationController

  def search
    search_area = params[:search_area]
    search_method = params[:search_method]
    if search_area == "users"
      if search_method == "all"
        @users = User.where('name = ?', "#{params[:keyword]}")
      else
        @users = User.where('name like?', "%#{params[:keyword]}%")
      end
    else
      if search_method == "all"
        @books = Book.where('title = ?', "#{params[:keyword]}")
      else
        @books = Book.where('title like?', "%#{params[:keyword]}%")
      end
      render "search"
    end
  end

  def category
    @book = Book.new
    @a = Book.where(created_at: Date.today.all_day).count
    @b = Book.where(created_at: Date.today.days_ago(1).all_day).count
    @c = Book.where(created_at: Date.today.days_ago(2).all_day).count
    @d = Book.where(created_at: Date.today.days_ago(3).all_day).count
    @e = Book.where(created_at: Date.today.days_ago(4).all_day).count
    @f = Book.where(created_at: Date.today.days_ago(5).all_day).count
    @g = Book.where(created_at: Date.today.days_ago(6).all_day).count
    @books = Book.where("category = ?", "#{params[:category]}")
  end

  def link_category
    @book = Book.new
    @a = Book.where(created_at: Date.today.all_day).count
    @b = Book.where(created_at: Date.today.days_ago(1).all_day).count
    @c = Book.where(created_at: Date.today.days_ago(2).all_day).count
    @d = Book.where(created_at: Date.today.days_ago(3).all_day).count
    @e = Book.where(created_at: Date.today.days_ago(4).all_day).count
    @f = Book.where(created_at: Date.today.days_ago(5).all_day).count
    @g = Book.where(created_at: Date.today.days_ago(6).all_day).count
    @books = Book.where(category: params[:category])
  end
end
