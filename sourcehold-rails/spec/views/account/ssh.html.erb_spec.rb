require 'spec_helper'

describe "account/ssh.html.erb" do
  #pending "add some examples to (or delete) #{__FILE__}"

  it "should render the ssh template" do
    pending "until I figure out the authenticate thing"
    assign(:current_user, Factory.create(:user))
    render
    rendered.should render_template("ssh")
  end


end
