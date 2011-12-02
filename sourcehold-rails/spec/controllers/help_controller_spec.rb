require 'spec_helper'

describe HelpController do

  describe "GET 'ssh'" do
    it "should be successful" do
      get 'ssh'
      response.should be_success
    end
  end

end
