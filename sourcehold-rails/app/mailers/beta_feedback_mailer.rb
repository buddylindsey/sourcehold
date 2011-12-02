class BetaFeedbackMailer < ActionMailer::Base
  default :from => "buddy@sourcehold.com"

  def feedback(content, url, username, email)
    @current_url = url
    @user = username
    @user_email = email
    @content = content
    
    mail(:to => "buddy@sourcehold.com",
         :subject => "[Footer Feedbac] - #{@user}")

  end
end
