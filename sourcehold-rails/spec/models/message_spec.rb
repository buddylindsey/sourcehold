require 'spec_helper'

describe Message do

  before(:each) do
    User.new(:id => 1, 
             :username => "buddy", 
             :password => "blob45jfK!", 
             :password_confirmation => "blob45jfK!", 
             :email => "buddy@buddy.com").save!

    User.new(:id => 2, 
             :username => "shane", 
             :password => "blob123!", 
             :password_confirmation => "blob123!", 
             :email => "shane@shane.com").save!

    Message.new(:user_id => 1, 
                :to_id => 2,
                :subject => "The subject is awesome", 
                :body => "I am an awesome body of the message").save!
  end

  it "should have a user for the sender" do
    Message.find(1).sender.username.should == "buddy"
  end

  it "should have a user for the recipient" do
    Message.find(1).recipient.username.should == "shane"
  end
end
