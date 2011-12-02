class Message < ActiveRecord::Base
  validates_numericality_of :user_id
  validates_numericality_of :to_id
  validates_presence_of :user_id, :to_id

  def sender
    User.find(self.user_id)
  end

  def recipient
    User.find(self.to_id)
  end
end
