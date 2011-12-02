class SupportController < ApplicationController
  def feedback
    if(user_signed_in?)
      username = current_user.username
      email = current_user.email
    else
      username = 'anon'
      email = 'anon@anon.com'
    end
    BetaFeedbackMailer.feedback(params[:content], params[:path], username, email).deliver
    redirect_to params[:path]
  end
end
