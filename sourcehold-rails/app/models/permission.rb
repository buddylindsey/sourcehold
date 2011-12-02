class Permission < ActiveRecord::Base
  validates_presence_of :user_id, :repository_id, :permission
  validates_length_of :permission, :maximum => 3
  
  def user
    u = User.find(self.user_id)
  end

  def repo
    r = Repository.find(self.repository_id)
  end
end
