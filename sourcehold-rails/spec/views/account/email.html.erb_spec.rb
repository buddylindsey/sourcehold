require 'spec_helper'

describe "account/email.html.erb" do
  #pending "add some examples to (or delete) #{__FILE__}"
  
  it "renders the email template" do
    pending "Until I can figure out how to do this"
    assign(:emails, [Factory.create(:email)] )
    render
    view.should render_template("email")
  end

  it "displays add email form" do
    pending "until I am smart enough to figure out factory objects"
    render
    rendered.should contain("form")
    rendered.should contain("Add")
  end
end
