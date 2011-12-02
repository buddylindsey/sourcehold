module ApplicationHelper
  def css_class_public(state)
    if(state)
      return "public"
    else
      return "private"
    end
  end

  def information_checker
    user = current_user

    final = Hash.new

    if(user.authorized_keys.count == 0)
      final[:keys] = 0 
    end

    if(user.repositories.count == 0)
      final[:repos] = 0
    end

    return final
  end

  def title(page_title)
    content_for :title, page_title.to_s
  end

  def meta_description(description)
    content_for :meta_description, description.to_s
  end
end
