require 'spec_helper'

describe RepoController do
  describe 'creates a new repository' do
    context "but repository already exist" do
      login_user
      it "it should redirect to repository" do
        Repository.stub(:exist?).and_return(true)
        post :create, :repo_name => "the_repo"
        response.should redirect_to("/#{subject.current_user.username}/the_repo")
      end
    end

    context "but the repository isn't created" do
      login_user

      it "it should redirect to the dashboard" do
        Repository.stub(:exist?).and_return(false)

        repo = mock_model(Repository)
        repo.stub!(:create_the_repo).and_return(false)

        Repository.should_receive(:new).and_return(repo)

        post :create, { :repo_name => "test_repo" }
        response.should redirect_to "/dashboard"
      end
    end
  
    context "and the repo is created, but not saved to the database" do
      login_user

      before(:each) do
        @repo = mock_model(Repository)
        @repo.stub!(:create_the_repo).and_return(true)
        @repo.stub!(:save!).and_return(false)
        @repo.stub!(:user_id=)
        @repo.stub!(:name=)
        @repo.stub!(:public=)
      end

      it "it should redirect to dashboard" do
        Repository.stub(:exist?).and_return(false)
        Repository.should_receive(:new).and_return(@repo)

        post :create, {:repo_name => "test_repo", :public => "false" }
        response.should redirect_to "/dashboard"
      end
    end
    
    context "and the repo is created, and saved to the database" do 
      login_user

      it "it should redirect to the repositories page" do
        Repository.stub(:exist?).and_return(false)

        @repo = mock_model(Repository)
        @repo.stub!(:create_the_repo).and_return(true)
        @repo.stub!(:save!).and_return(true)
        @repo.stub!(:user_id=)
        @repo.stub!(:name=)
        @repo.stub!(:public=)

        Repository.should_receive(:new).and_return(@repo)
        post :create, { :repo_name => "test_repo", :public => "false" }

        response.should redirect_to "/#{subject.current_user.username}/test_repo"
      end
    end
  end

  describe 'allow a user to create a new repository' do
    context 'if user is not logged in' do
      it "should redirect to signin form" do
        get :new
        response.should redirect_to "/users/sign_in"
      end
    end

    context 'if use is logged in' do
      login_user
      
      it "should present the user with the new repo page" do
        get :new
        response.should be_success
      end
    end
  end
end
