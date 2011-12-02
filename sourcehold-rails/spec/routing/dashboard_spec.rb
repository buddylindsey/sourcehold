require 'spec_helper'

describe "routing to dashboard" do
  it "routes a get verb on /dashboard to dashboard#index" do
    { :get => "/dashboard" }.should route_to(
      :controller => "dashboard",
      :action => "index"
    )
  end
end
