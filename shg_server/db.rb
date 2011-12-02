require 'mysql2'

class DB
  def init
    if(ENV['SHG_ENV'] == "production")
      @conn = Mysql2::Client.new(:host => "", :username => "", :password => "", :database => "")
    else
      @conn = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "", :database => "sourcehold")
    end
  end
end
