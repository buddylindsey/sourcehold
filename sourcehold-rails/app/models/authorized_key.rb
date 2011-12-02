class AuthorizedKey < ActiveRecord::Base
  validates_length_of :key, :minimum => 300 
  validates_presence_of :key, :name, :user_id
  validates_numericality_of :user_id  

  def save_to_file(username)
    require 'drb'
    s = DRbObject.new_with_uri("druby://localhost:61438")
    s.add_key(username, self.key)
  end
end
