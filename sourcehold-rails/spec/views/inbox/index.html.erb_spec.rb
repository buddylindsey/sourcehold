require 'spec_helper'

describe "inbox/index.html.erb" do
  #pending "add some examples to (or delete) #{__FILE__}"

  it "should render index template" do
    assign(:messages, [])
    render
    rendered.should render_template("index")
  end
end
