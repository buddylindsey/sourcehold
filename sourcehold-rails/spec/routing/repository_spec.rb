require 'spec_helper'

describe "routing to repository actions" do
  it "routes a get verb on /repo/new to repo#new" do
    { :get => "/repo/new" }.should route_to(
      :controller => "repo",
      :action => "new"
    )
  end

  it "routes a post verb on /repo to repo#create" do
    { :post => "/repo" }.should route_to(
      :controller => "repo",
      :action => "create"
    )
  end

  it "routes a put verb on /repo to repo#update" do
    { :put => "/repo" }.should route_to(
      :controller => "repo",
      :action => "update"
    )
  end
end
