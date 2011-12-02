require 'spec_helper'

describe AccountController do

  describe "Get 'index'" do
    it 'should redirect to sign in page' do
      get 'index'
      response.should redirect_to('/users/sign_in')
    end
  end

  describe "GET 'index'" do
    login_user

    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'ssh'" do
    login_user

    it "should be successful" do
      get 'ssh'
      response.should be_success
    end
  end

  describe "GET 'profile'" do
    login_user

    it "should be successful" do
      get 'profile' 
      response.should be_success
    end
  end

  describe "GET 'email'" do
    login_user
    it "should be successful" do
      get 'email'
      response.should be_success
    end
  end
end
