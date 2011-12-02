require 'spec_helper'

describe DashboardController do
  context "visiting the dashboard" do
    context 'user is logged in' do
      login_user
      it 'should make sure the user is logged in' do
        get :index
        response.should be_success
      end
    end

    context 'user not logged in' do
      it 'should redirect to sign in' do
        get :index
        response.should redirect_to "/users/sign_in"
      end
    end
  end
end
