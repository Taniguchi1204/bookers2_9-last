class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user_id = current_user.id
    if @group.save
      current_user.group_users.create(group_id: @group.id)
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end

  def index
    @book = Book.new
    @groups = Group.all
  end

  def show
    @book = Book.new
    @group = Group.find(params[:id])
  end

  def event
    @group = Group.find(params[:group_id])
  end

  def email_create
    @group = Group.find(params[:group_id])
    group_users = @group.users
    @title = params[:title]
    @content = params[:content]
    UserMailer.create_event(group_users, @title, @content).deliver
  end

  private

  def group_params
    params.require(:group).permit(:group_name,:group_introduction,:image)
  end
end
