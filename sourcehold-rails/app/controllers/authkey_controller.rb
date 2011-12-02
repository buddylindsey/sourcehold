class AuthkeyController < ApplicationController
  def create
    a = AuthorizedKey.new
    a.name = params[:name]
    a.key = params[:key]
    a.user_id = current_user.id
    if(a.save)
      a.save_to_file(current_user.username)
    end
    redirect_to "/account/ssh"
  end

  def destroy
    auth = AuthorizedKey.find(params[:id])
    auth.destroy

    redirect_to "/account/ssh"
  end
end
