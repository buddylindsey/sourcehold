require 'spec_helper'

describe "routing to account information" do
  it "routes /account to account#index" do
    { :get => "/account" }.should route_to(
      :controller => "account",
      :action => "index"
    )
  end

  it "routes /account/repos to account#repos" do
    { :get => "/account/repos" }.should route_to(
      :controller => "account",
      :action => "repos"
    )
  end

  it "routes /account/ssh to account#ssh" do
    { :get => "/account/ssh" }.should route_to(
      :controller => "account",
      :action => "ssh"
    )
  end

  it "routes a get verb on /account/profile to account#profile" do
    { :get => "/account/profile" }.should route_to(
      :controller => "account",
      :action => "profile"
    )
  end

  it "routes a get verb on /account/email to account#email" do
    { :get => "/account/email" }.should route_to(
      :controller => "account",
      :action => "email"
    )
  end

  it "routes a post on /email to account#add_email" do
    { :post => "/email" }.should route_to(
      :controller => "account",
      :action => "add_email"
    )
  end

  it "routes a post verb on account/profile to account#edit_profile" do
    { :post => "account/profile" }.should route_to(
      :controller => "account",
      :action => "edit_profile"
    )
  end
end
