class Repository < ActiveRecord::Base
  has_many :permissions

  validates_presence_of :user_id, :name
  validates_numericality_of :user_id

  def owner 
    User.find(self.user_id)
  end

  def create_the_repo(user, name, pub)
    require 'drb'
    s = DRbObject.new_with_uri("druby://localhost:61438")
    s.create_repo(user, name, pub)
  end

  def delete_the_repo
    require 'drb'
    s = DRbObject.new_with_uri("druby://localhost:61438")
    s.delete_repo(self.owner.username, self.name)
  end

  def self.fork(original_user, new_user, repository, pub)
    require 'drb'
    s = DRbObject.new_with_uri("druby://localhost:61438")
    s.fork(original_user, new_user, repository, pub)
  end

  def self.make_public(user, repo)
    require 'drb'
    s = DRbObject.new_with_uri("druby://localhost:61438")
    s.make_public(user, repo)
  end

  def self.make_private(user, repo)
    require 'drb'
    s = DRbObject.new_with_uri("druby://localhost:61438")
    s.make_private(user, repo)
  end

  def repo_size(username)
    #`du -sm #{GIT_REPOS + "/" + username + "/" + self.name + ".git"}`.split("\t")[0]
  end

  def self.exist?(user_id, repo_name)
    if(Repository.where("user_id = ? AND name = ?", user_id, repo_name).empty?)
      return false
    else
      return true
    end
  end
end
