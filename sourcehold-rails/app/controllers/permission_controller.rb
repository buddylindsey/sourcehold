class PermissionController < ApplicationController
  def create
    user = User.find_by_username(params[:username])
    repo = Repository.find(params[:repo_id])

    permission = Permission.new
    permission.user_id = user.id
    permission.repository_id = repo.id
    permission.permission = "RW"

    if(permission.save)
      redirect_to "/#{current_user.username}/#{repo.name}/admin" 
    else
      flash[:notice] = "No user with that username"
      redirect_to "/#{current_user.username}/#{repo.name}/admin"
    end

  end

  def destroy
    permission = Permission.find(params[:id])
    permission.destroy

    flash[:notice] = "User Removed"

    redirect_to :dashboard
  end
end
