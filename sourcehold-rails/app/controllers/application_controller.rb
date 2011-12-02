class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_url
  end

  def not_found
    raise ActionController::RoutingError.new("Not Found")
  end

  def raise_404
    render :file => "#{RAILS_ROOT}/public/404.html", :layout => false, :status => 404
  end

end
