class GroupUsersController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    join = current_user.group_users.new(group_id: @group.id)
    join.save
    redirect_to groups_path
  end

  def destroy
    @group = Group.find(params[:group_id])
    leave =  current_user.group_users.find_by(group_id: @group.id)
    leave.destroy
    redirect_to groups_path
  end
end
