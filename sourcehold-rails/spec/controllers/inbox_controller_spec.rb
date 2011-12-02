require 'spec_helper'

describe InboxController do

  describe "when a user goes to the inbox" do
    context "and the user is logged in" do
      login_user

      it "should go to the inbox" do
        get 'index'
        response.should be_success
      end
    end

    context "the user is not logged int" do
      it "should be successful" do
        get 'index'
        response.should redirect_to "/users/sign_in"
      end
    end
  end

  describe "when a user creates a message" do
    login_user

    it "should save the message" do
      user = Factory.build(:user)
      User.stub!(:find_by_username).and_return(user)

      post :create, {:subject => "Hello World", :body => "I am a body", :user_to => user.id }
      response.should redirect_to({ :controller => :inbox, :action => :sent })
    end


    context "and when the message saves successfully" do
      before(:each) do
        @user = Factory.build(:user)
        User.stub!(:find_by_username).and_return(@user)
      end

      it "sets a flash[:notice] message" do
        post :create, {:subject => "Hello World", :body => "I am a body", :user_to => @user.id }
        flash[:notice].should eq("The message was sent successfully")
      end

      it "redirectes to the messages index" do
        post :create, {:subject => "Hello World", :body => "I am a body", :user_to => @user.id }
        response.should redirect_to(:action => "sent")
      end
    end
  end

  describe "when a user wants to view all sent messages" do
    context "and the user is logged in" do
      login_user
      it "should go tot he sent messages page" do
        get :sent
        response.should be_success
      end
    end

    context "and the user is not logged in" do
      it "should redirect to login page" do
        get :sent
        response.should redirect_to "/users/sign_in"
      end
    end
  end
end
