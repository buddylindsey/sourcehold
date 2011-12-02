class HomeController < ApplicationController
  def index
    if(user_signed_in?)
      redirect_to :dashboard
    end

    @blog_posts = BlogPost.order("created_at DESC").limit(5)
  end

  def terms
  end

  def privacy
  end

  def pricing
  end
end
