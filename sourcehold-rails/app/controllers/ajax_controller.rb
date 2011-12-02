class AjaxController < ApplicationController
  def username_exist
    user = User.find_by_username(params[:name])

    if(user.nil?)
      render :json => 'false'
    else
      render :json => 'true'
    end

  end

  def email_exist
    user = User.find_by_email(params[:email])
    email = Email.find_by_email_address(params[:email])

    if(user.nil? && email.nil?)
      render :json => 'false'
    else
      render :json => 'true'
    end
  end

  def repo_exist
    repo = Repository.where("user_id = ? AND name = ?", current_user.id, params[:repo])

    if(repo.empty?)
      render :json => 'false'
    else
      render :json => 'true'
    end
  end
end
