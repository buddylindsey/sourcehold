class Email < ActiveRecord::Base
  include Gravtastic
  gravtastic :email_address, :secure => :true, :size => 16 
  validates_uniqueness_of :email_address
  validates_presence_of :user_id, :email_address
  validates_numericality_of :user_id 

  def avatar
    return self.gravatar_url
  end

  def user
    User.find(self.user_id)
  end
end
