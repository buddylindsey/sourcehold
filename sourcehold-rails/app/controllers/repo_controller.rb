class RepoController < ApplicationController
  before_filter :authenticate_user!, :except => [:tree, :blob, :fork, :archives, :default, :commits, :commit]
  before_filter :allowed_access?, :except => [:new, :create, :update, :destroy]

  def create
    final_repo_name = process_repo_name(params['repo_name'])

    if(!Repository.exist?(current_user.id, final_repo_name))
      r = Repository.new 

      if(params['public'] == 'false') 
        pbs = false 
      else
        pbs = true
      end

      if(r.create_the_repo(current_user.username, final_repo_name, pbs))
        r.user_id = current_user.id
        r.name = final_repo_name
        r.public = pbs
        if(r.save!)
          ActionLog.new(:user_id => current_user.id, :action => "new repo").save
          flash[:notice] = "#{final_repo_name} repository created"
          redirect_to "/#{current_user.username}/#{final_repo_name}" 
        else
          flash[:notice] = "#{final_repo_name} repository was not created"
          redirect_to :dashboard
        end
      else
        flash[:notice] = "Git repository was not created"
        redirect_to :dashboard
      end
    else
      flash[:notice] = "Repository by that name already exists"
      redirect_to "/#{current_user.username}/#{final_repo_name}"
    end
  end

  def new
  end

  def destroy
    the_repo = Repository.where("id = ? AND user_id = ?", params[:id], current_user.id).first

    if(current_user.id != the_repo.owner.id)
      redirect_to :root
    end

    if(the_repo.delete_the_repo)

      Permission.find_all_by_repository_id(the_repo.id).each do |p|
        p.destroy
      end

      the_repo.destroy
      flash[:notice] = "Repository: #{the_repo.name} was removed"
      redirect_to :dashboard
    else
      flash[:notice] = "Something went wrong and the repo didn't get removed"
      redirect_to :dashboard
    end
  end

  def default
    user = User.find_by_username(params[:user])

    if(user.nil?)
      raise_404
    else
      repo = "#{params[:user]}/#{params[:repo]}"
      branch = "master"
      @branches = GitRepo.new.the_repo(params[:user], params[:repo]).branches.map(&:name)
      @tree = GitRepo.new.tree(repo, branch, []) 
      if(user_signed_in?)
        @user_repos = User.find(current_user.id).repositories.map(&:name)
      end
    end
  end

  def tree
    if(params[:path].nil?)
      path = []
    else
      path = params[:path].split('/')
    end
    repo = "#{params[:user]}/#{params[:repo]}"
    @tree = GitRepo.new.tree(repo, params[:branch], path)

    @branches = GitRepo.new.the_repo(params[:user], params[:repo]).branches.map(&:name)

    if user_signed_in? then
      @user_repos = User.find(current_user.id).repositories.map(&:name)
    end
  end

  def blob
    path = params[:path].split('/')
    repo = "#{params[:user]}/#{params[:repo]}"

    @blob = GitRepo.new.blob(repo, params[:branch], path)
    @branches = GitRepo.new.the_repo(params[:user], params[:repo]).branches.map(&:name)
    if user_signed_in? then
      @user_repos = User.find(current_user.id).repositories.map(&:name)
    end
  end

  def admin
    if(current_user.username == params[:user])
      @repo = Repository.where("user_id = ? AND name = ?", current_user.id, params[:repo]).first
    else
      redirect_to :root
    end
  end

  def fork
    user = User.find_by_username(params[:user])
    rep = Repository.where("user_id = ? AND name = ?", user.id, params[:repo]).first

    if(Repository.fork(params[:user], current_user.username, rep.name, rep.public)) 

      r = Repository.new
      r.user_id = current_user.id
      r.name = params[:repo]

      if(rep.public)
        r.public = true
      else
        r.public = false
      end

      r.save
      ActionLog.new(:user_id => current_user.id, :action => "fork").save
      flash[:notice] = "#{params[:repo]} repository has been forked"
      redirect_to :dashboard
    else
      flash[:notice] = "Repository was not forked for some reason"
      redirect_to :dashboard
    end
  end

  def commits
    if(params[:page].nil?)
      @repo_commits = GitRepo.new.the_repo(params[:user], params[:repo]).commits(params[:branch], 30)
    else
      @repo_commits = GitRepo.new.the_repo(params[:user], params[:repo]).commits(params[:branch], 30, ((params[:page].to_i - 1) * 30))
    end

    @branches = GitRepo.new.the_repo(params[:user], params[:repo]).branches.map(&:name)
    if user_signed_in? then
      @user_repos = User.find(current_user.id).repositories.map(&:name)
    end
  end

  def commit
    @commit = GitRepo.new.the_repo(params[:user], params[:repo]).commit(params[:sha_id])

    @branches = GitRepo.new.the_repo(params[:user], params[:repo]).branches.map(&:name)
    if user_signed_in? then
      @user_repos = User.find(current_user.id).repositories.map(&:name)
    end
  end

  def archives
    ActionLog.new(0, :action => "downlaod").save
    repo = GitRepo.new.the_repo(params[:user], params[:repo])

    send_data(repo.archive_tar, :filename => "#{params[:repo]}.tar", :type => "application/zip")
  end

  def update
    repo = Repository.find(params[:repo_id])

    if(params['public'] == 'false') 
      private_repo = false 
      Repository.make_private(repo.owner.username, repo.name)
    else
      Repository.make_public(repo.owner.username, repo.name)
      private_repo = true
    end

    if (!repo.update_attribute('public', private_repo))
      flash[:notice] = "Something went wrong and repo did not change to #{private_repo}"
    end

    redirect_to "/#{current_user.username}/#{repo.name}/admin"
  end

  private

  def allowed_access? 
    owner = User.find_by_username(params[:user])
    repository = Repository.where("user_id = ? AND name = ?", owner.id, params[:repo]).first

    if(repository.public)
      return true
    end

    if(user_signed_in?)
      if(current_user.username == params[:user])
        return true
      else
        current_user.permissions.each do |p|
          if(p.repo.id == repository.id)
            return true
          end
        end

        redirect_to :root
      end
    else
      redirect_to :root
    end
  end

  def process_repo_name(name)
    final_name = name.gsub(' ', '-')
    final_name = final_name.gsub('\'', '')
    return final_name
  end
end
