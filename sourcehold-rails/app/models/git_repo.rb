class GitRepo

  def the_repo(user, repo)
    repo = Grit::Repo.new("#{GIT_REPOS}/#{user}/#{repo}.git")
  end

  def branches(repo)
    the_repo = Grit::Repo.new("#{GIT_REPOS}/#{repo}.git")
    return the_repo.branches
  end

  def blob(repo, branch, path)
    the_repo = Grit::Repo.new("#{GIT_REPOS}/#{repo}.git")
    main_tree = the_repo.tree(branch)
    
    # removing last element from array which is name of file
    # and getting it ready to be sent to tree method
    name = path.pop

    tree = self.tree(repo, branch, path) 

    tree.contents.each do |b|
      if(b.name == name)
        return b
      end
    end
  end

  def tree(repo, branch, path)
    main_repo = Grit::Repo.new("#{GIT_REPOS}/#{repo}.git")
    lt = main_repo.tree(branch)

    path.each do |p|
      lt.contents.each do |l|
        if(l.class.to_s == "Grit::Tree" && l.name == p)
          lt = l
        end
      end
    end

    return lt
  end
end

