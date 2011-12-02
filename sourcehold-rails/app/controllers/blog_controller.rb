class BlogController < ApplicationController
  def index
    # paginate
    @blog_posts = BlogPost.order("created_at DESC")
  end

  def post
    @post = BlogPost.find(params[:id])
  end

  def rss
    @posts = BlogPost.find(:all, :order => "id DESC", :limit => 20)
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end

  def new
    if(user_signed_in?)
      if(current_user.username == "buddylindsey" || current_user.username == "buddy")
      else
        redirect_to "/blog"
      end
    else
      redirect_to "/blog"
    end
  end

  def create
    blog_post = BlogPost.new

    blog_post.user_id = current_user.id
    blog_post.title = params[:title]
    blog_post.body = params[:body]
    blog_post.published = true

    if(blog_post.save)
      redirect_to "/blog" 
    else
      redirect_to :new
    end

  end

  def comment
    if(user_signed_in?)
      blog_comment = BlogComment.new

      blog_comment.post_id = params[:post_id]
      blog_comment.body = params[:body]
      blog_comment.user_id = current_user.id

      post = BlogPost.find(params[:post_id])
      if(blog_comment.save)
        flash[:comment] = "Comment Submitted"
        redirect_to "/blog/#{params[:post_id]}/#{post.urlized_title}"
      else
        redirect_to "/blog/#{params[:post_id]}/#{post.urlized_title}"
      end
    else
      redirect_to "/blog"
    end
  end
end
