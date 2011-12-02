require 'spec_helper'

describe Email do

  before(:each) do
    User.new(:id => 1, 
             :username => "buddy", 
             :password => "blob45jfK!", 
             :password_confirmation => "blob45jfK!", 
             :email => "buddy@buddy.com").save!
    
    Email.new(:user_id => 1,
              :email_address => "test@joebob.com").save!

    Email.new(:user_id => 1,
              :email_address => "jacob@jokab.com").save!
  end

  it "Should be an email object" do
    e = Email.find(1)
    e.class.to_s.should == "Email"
  end

  it "Should have a user object" do
    e = Email.find(1)
    e.user.class.to_s.should == "User"
  end

  it "Should have many emails" do
    u = User.find(1)
    u.emails.size.should == 2
  end
end
