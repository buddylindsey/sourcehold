class AccountController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = User.find(current_user.id)
  end

  def ssh

  end

  def profile
    if(current_user.profile.nil?)
      @profile = Profile.new
    else
      @profile = current_user.profile
    end
  end

  def edit_profile
    profile = current_user.profile

    if(profile.nil?)
      p = Profile.new
      p.user_id = current_user.id
      p.fullname = params[:fullname]
      p.website = params[:website]
      p.company = params[:company]
      p.location = params[:location]
      p.alternate_contact = params[:contact]

      if(p.save)
        redirect_to :action => :profile
      end
    else
      hash = ["fullname" => params[:fullname],
              "website" => params[:website],
              "company" => params[:company],
              "location" => params[:location],
              "alternate_contact" => params[:contact]]

      if(profile.update_attributes(hash))
        redirect_to :action => :profile
      end
    end
  end

  def email
    @emails = Email.find_all_by_user_id(current_user.id)
  end

  def add_email
    @email = Email.new
    @email.user_id = current_user.id
    @email.email_address = params[:email]

    if(@email.save)
      redirect_to "/account/email"
    else
      redirect_to "/account/email"
    end
  end

  def delete_email
    email = Email.find(params[:id])
    email.destroy

    redirect_to "/account/email"
  end

  def repos
  end
end
