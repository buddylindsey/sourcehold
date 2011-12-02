require 'spec_helper'

describe BlogController do
  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'post'" do

    before(:each) do
      BlogPost.new(:title => "hello world").save
    end

    it "should be successful" do
      get :post, { :id => 1, :title => "hello world" } 
      response.should be_success
    end
  end

  describe 'should try to access the new blog post page' do
    login_user 
    it "it should render new blog post page" do
      subject.current_user.stub!(:username).and_return("buddy")

      get :new
      response.should be_success
    end

    it "it should not go to the new blog post page even if logged in" do
      get :new
      response.should redirect_to("/blog")
    end
  end

  describe 'should try to access the new blog post page' do
    it "it should not go to the new blog post page because of not being logged in" do
      get :new
      response.should redirect_to "/blog"
    end
  end
end
