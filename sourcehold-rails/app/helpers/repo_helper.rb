module RepoHelper
  def generate_repo_url(user, repo, object, branch, path, file)
    if(path.nil?)
      return "/#{user}/#{repo}/#{object}/#{branch}/#{file}"
    else
      return "/#{user}/#{repo}/#{object}/#{branch}/#{path}/#{file}"
    end
  end

  def latest_commit_data(user, repo, path)
    return GitRepo.new.the_repo(user, repo).log(path).first.message
  end

  def user_avatar(username)
    return User.find_by_username(username).avatar
  end

  def determine_current_page_is_source
    if(params[:action] == "default" || params[:action] == "tree" || params[:action] == "blob")
      return true
    end
  end

  def determine_current_page_is_commits
    if(params[:action] == "commits" || params[:action] == "commit")
      return true
    end
  end

  def diff_highlight(diff)
    return highlight(diff.a_path, diff.diff)
  end

  def highlight(name, data)
    lexer = Linguist::FileBlob.new(name)

    if(lexer.binary?)
      return "binary"
    elsif(lexer.visual_studio_project_file?)
      return Albino.new(data, 'xml', :html)
    elsif(lexer.extname == ".vssettings" || lexer.extname == ".build")
      return Albino.new(data, 'xml', :html)
    elsif(lexer.name.to_s.include?("."))
      begin
        if(lexer.lexer.name.downcase == "text only")
          return Albino.new(data, lexer.lexer.aliases[0]).colorize
        else
          return Albino.new(data, lexer.lexer.aliases[0]).colorize
        end
      rescue
        logger.info "RESCUED: no lexar"
        return Albino.new(data, 'text', :html)
      end
    else
      return check_whole_file_name(name, data)
    end
  end

  def syntax_highlight_code(blob)
    return highlight(blob.name, blob.data)
  end

  def check_whole_file_name(name, data)
    if(name.include?("Rakefile"))
      return Albino.new(data, 'ruby', :html)
    elsif(name.include?("Gemfile"))
      return Albino.new(data, 'ruby', :html)
    else
      return Albino.new(data, 'text', :html)
    end
  end

  def commit_user_by_email(author)
    user = User.find_by_email(author.email)

    if(user.nil?)
      user = Email.find_by_email_address(author.email)

      if(!user.nil?)
        user = user.user
      end
    end

    if(!user.nil?)
      return user
    else
      return nil
    end
  end

  def can_access_repo?
    if(current_user.username == params[:user])
      return true
    else
      current_user.permissions.each do |p|
        if(p.repo.name == params[:repo])
          user = User.find_by_username(params[:user])
          repo = Repository.where("user_id = ? AND name = ?", user.id, params[:repo]).first

          if(p.repo.id == repo.id)
            return true
          end
        end
      end
      return false
    end
  end

  def generate_breadcrumb(path)
    parts = path.split("/")
    parts.delete_at(0)

    result = Hash.new
    result["username"] = parts[0]
    result["repo"] = parts[1]
    result["pathArray"] = Array.new
    lilCounter = 0
    parts.each do |x|
      if(lilCounter > 2)
        result["pathArray"].push(x)
      else
        lilCounter += 1
      end
    end
    #return hash
    return result
  end


  def fun_stuff(path)
    parts = path.split("/")
    url_part_1 = "#{parts[0]}/#{parts[1]}/#{parts[2]}/tree/#{parts[4]}"
    parts.delete_at 1
    parts.delete_at 2
    parts.delete_at 2
    parts.delete_at 0

    url_part_1

    list_of_urls = [url_part_1]

    repo = parts[0]
    parts.delete_at 0

    parts.each do |p1|
      final_url = url_part_1
      parts.each do |p2|
        if(p1 == p2)
          final_url = "#{final_url}/#{p2}"
          break
        else
          final_url = "#{final_url}/#{p2}"
        end
      end
      list_of_urls.push final_url
    end
    list_of_urls
  end
end
