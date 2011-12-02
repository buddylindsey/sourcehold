class ProfileController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]

  def index
    @user = User.find_by_username(params['user']) || raise_404
  end
end
