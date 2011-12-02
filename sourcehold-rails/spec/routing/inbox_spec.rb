require 'spec_helper'

describe "routing to inbox messages" do
  it "routes /inbox to inbox#index" do
    { :get => "/inbox" }.should route_to(
      :controller => "inbox",
      :action => "index"
    )
  end

  it "routes post verb on /inbox to inbox#create" do
    { :post => "/inbox" }.should route_to(
      :controller => "inbox",
      :action => "create"
    )
  end

  it "routes a post verb on /reply to inbox#reply" do 
    { :post => "/reply" }.should route_to(
      :controller => "inbox",
      :action => "reply"
    )
  end

  it "routes a get verb on /inbox/compose to inbox#new" do
    { :get => "/inbox/compose" }.should route_to(
      :controller => "inbox",
      :action => "new"
    )
  end

  it "routes a get verb on /inbox/sent to inbox#sent" do
    { :get => "/inbox/sent" }.should route_to(
      :controller => "inbox",
      :action => "sent"
    )
  end
end
