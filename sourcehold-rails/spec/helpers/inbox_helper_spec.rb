require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the InboxHelper. For example:
#
# describe InboxHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe InboxHelper do
  describe "get parent message if one exists" do
    it "should get parent message" do
      msg1 = Factory.build(:message)
      msg2 = Factory.build(:message)
      msg2.stub(:parent).and_return(msg1)

      helper.parent(msg2).should be msg1
    end
  
    it "should return id of parent" do
      msg = Factory.build(:message)
      msg.stub(:parent).and_return(nil)

      helper.parent(msg).should equal(msg.id)
    end
  end
end
