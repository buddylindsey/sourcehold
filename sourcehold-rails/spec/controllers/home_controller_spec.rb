require 'spec_helper'

describe HomeController do
  describe 'Visiting home page' do
    context 'user not logged in' do
      it 'should view home page' do
        get :index
        response.should be_success
      end
    end

    context 'user logged in' do
      login_user

      it 'should redirect to dashboard' do
        get :index
        response.should redirect_to "/dashboard"
      end
    end
  end
end
