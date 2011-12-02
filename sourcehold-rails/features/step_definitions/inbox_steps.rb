When /^I send a message$/ do
  visit "/inbox/compose"
  fill_in "subject", :with => "I am a subject"
  fill_in "user_to", :with => "test_dude"
  fill_in "body", :with => "I am a body of a message"
  click_button "send"
end

Then /^I should see it as a sent message$/ do
  visit "/inbox/sent"
  page.should have_content("I am a subject")
end

When /^I recieve a message$/ do
  
end

Then /^I should see the message in a stream in my inbox$/ do
  visit '/inbox'
  page.should have_content 'I am a subject'
  page.should have_content 'test_dude'
end

When /^I view a message$/ do
  visit "/inbox"
  click_link "I am a subject"
end

When /^I reply to that message$/ do
  fill_in "reply_field", :with => "I is a reply"
  click_button "reply"
end

Then /^I should see both messages on the same page$/ do
  page.should have_content "I is a reply"
  page.should have_content "I am a subject"
  page.should have_content "I am a body of a message"
end

Given /^Someone else is available$/ do
email = "test@dude.com"
password = "P4ssW0rd!"
username = "test_dude"
  Given %{I have one user "#{email}" with password "#{password}" and username "#{username}"}
end

Given /^Another user is signed in$/ do
  visit "/users/sign_in"
  And %{I fill in "user_email" with "test@dude.com"}
  And %{I fill in "user_password" with "P4ssW0rd!"}
  click_button "Sign in"
end

Given /^They send me a message$/ do
  Given %{Another user is signed in}
  visit "/inbox/compose"
  fill_in "subject", :with => "I am a subject"
  fill_in "user_to", :with => "test_guy"
  fill_in "body", :with => "I am a body of a message"
  click_button "send"
  Given %{I sign out}
end

Given /^I sign out$/ do
  click_link "Log Out"
end

When /^I log in$/ do
  visit "/users/sign_in"
  And %{I fill in "user_email" with "buddy@buddylindsey.com"}
  And %{I fill in "user_password" with "p4ssW0rd"}
  click_button "Sign in"
end
