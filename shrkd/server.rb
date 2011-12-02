require 'drb'
require 'drb/acl'
require 'grit'

#$SAFE = 1

# add what needs to be added for production check

class RepoKeyServer

  LOCAL_REPOS = "" # file location of local repos
  AUTH_KEY_FILE = "" # authorized_key file in some .ssh folder
  SCRIPT_NAME = "" # name of the script file to run

  ARG = [LOCAL_REPOS, AUTH_KEY_FILE, SCRIPT_NAME]
  #ARG = ["/main/repos", "/main/repos/.ssh/authorized_keys", "/main/repos/.shg/main.rb"]
  REPOS_LOCATION = ARG[0]

  def create_repo(user, name, pub)
    g = Grit::Repo.init_bare("#{REPOS_LOCATION}/#{user}/#{name}.git")
    if(g.class.to_s == "Grit::Repo")
      if(pub)
        make_public(user, name)
      end
      return true
    else
      return false
    end
  end

  def add_key(user, key)
    save_to_file(user, key)
  end

  def fork(original_user, new_user, repo, pub)
    old_repo = Grit::Repo.new("#{REPOS_LOCATION}/#{original_user}/#{repo}.git")
    new_repo = old_repo.fork_bare("#{REPOS_LOCATION}/#{new_user}/#{repo}.git")

    if(new_repo.class.to_s == "Grit::Repo")
      if(pub)
        make_public(new_user, repo)
      end
      return true
    else
      return false
    end
  end

  def delete_repo(user, repo)
    system("rm -rf #{REPOS_LOCATION}/#{user}/#{repo}.git")
  end

  def make_public(user, repo)
    system("touch #{REPOS_LOCATION}/#{user}/#{repo}.git/git-daemon-export-ok")
  end

  def make_private(user, repo)
    system("rm -f #{REPOS_LOCATION}/#{user}/#{repo}.git/git-daemon-export-ok")
  end

  def rename(user, repo)
  end

private
  AUTHORIZED_KEYS_FILE = ARG[1]
  SSH_SCRIPT_LOCATION = ARG[2]

  def save_to_file(username, key)
    final_key = "command=\"#{SSH_SCRIPT_LOCATION} #{username}\" #{key}"

    File.open(AUTHORIZED_KEYS_FILE, 'a') do |f|
      f.puts final_key
    end
  end
end

acl = ACL.new(%W[deny all allow localhost])
DRb.start_service("druby://localhost:61438", RepoKeyServer.new)
DRb.thread.join
