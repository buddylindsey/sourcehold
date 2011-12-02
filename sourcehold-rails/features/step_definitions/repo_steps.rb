Given /^I have one\s+user "([^\"]*)" with password "([^\"]*)" and username "([^\"]*)"$/ do |email, password, username|
  User.new(:email => email,
           :password => password,
           :username => username,
           :password_confirmation => password).save!
        
end

Given /^I am logged in$/ do
  email = 'buddy@buddylindsey.com'
  password = "p4ssW0rd" 
  username = 'test_guy'

  Given %{I have one user "#{email}" with password "#{password}" and username "#{username}"}
  visit "/users/sign_in"
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  click_button "Sign in"
end

When /^I add a new private repository$/ do
  visit "/repo/new"
  
  fill_in "repo_name", :with => 'cucumber_test_repo'
  choose "public_false"
  click_button "New Repo"
end

Then /^I should see it on my repository page$/ do
  visit "/dashboard/"
  page.should have_content("cucumber_test_repo")
end

When /^I add a new public repository$/ do
  visit "/repo/new"

  fill_in "repo_name", :with => 'cucumber_test_repo'
  choose "public_true"
  click_button "New Repo"
end

Then /^I should see it on my public profile$/ do
  visit "/test_guy"
  page.should have_content("cucumber_test_repo")
end

When /^I have an existing repo$/ do
  When %{I add a new private repository}
end

When /^I delete the existing repo$/ do
  visit '/dashboard'
  click_button "delete"
end

Then /^I should not see it on my dashboard$/ do
  visit '/dashboard'
  page.should_not have_content("cucumber_test_repo")
end

When /^I have an existing private repo$/ do
  When %{I add a new private repository}
end

When /^I change it to private$/ do
  visit '/test_guy/cucumber_test_repo/admin'
  choose "public_false"
  click_button "update"
end

When /^I have an existing public repo$/ do
  When %{I add a new public repository}
end

When /^I change it to public$/ do
  visit '/test_guy/cucumber_test_repo/admin'
  choose "public_true"
  click_button "update"
end

Then /^I should see it on my dashboard$/ do
  visit '/dashboard'
  page.should have_content('cucumber_test_repo')
end

Then /^I should not see it on my public profile$/ do
  visit '/test_guy'
  page.should_not have_content('cucumber_test_repo')
end

When /^I delete the repo from the admin page$/ do
  visit '/test_guy/cucumber_test_repo/admin'
  click_button "Delete Repo"
end

Then /^I should see a usage steps since it is new$/ do
  visit '/test_guy/cucumber_test_repo'
  page.should have_content('Start Using New Repository')
end

