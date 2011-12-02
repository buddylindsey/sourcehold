require_relative 'db'

class User < DB

  def initialize(name)
    init
    @username = name
  end

  def id
    id = nil
    @conn.query("SELECT `id` FROM users WHERE `username` = '#{@username}'").each do |row|
      id = row['id']
    end
    return id
  end

  def allowed_to_access_repo?(repo_name) 
    results = []
    @conn.query("select `repositories`.`name` from repositories JOIN permissions ON `permissions`.`repository_id` = `repositories`.`id` AND `permissions`.`user_id` = '#{self.id}'").each do |row|
      results.push row["name"]
    end
    return results.include?(repo_name)
  end
end
