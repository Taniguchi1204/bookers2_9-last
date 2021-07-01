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
end
