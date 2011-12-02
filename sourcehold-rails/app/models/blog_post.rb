class BlogPost < ActiveRecord::Base
  
  def urlized_title
    return self.title.gsub(' ', '-').downcase
  end

  def user
    return User.find(self.user_id)
  end

  def blog_comments
    return BlogComment.where("post_id = ?", self.id)
  end
end
