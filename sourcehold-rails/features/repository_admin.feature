Feature: Interact With Repositores on Accounts

  So the user can have repositories, private and public,
  As a user
  I want to be able to add Private and Public repositories

  

  @private_repo
  Scenario: Add a private repository
    Given I am logged in
    When I add a new private repository
    Then I should see it on my repository page
  
  @public_repo
  Scenario: Add a public repository
    Given I am logged in
    When I add a new public repository
    Then I should see it on my public profile

  @change_to_public
  Scenario: Change from private repo to public
    Given I am logged in
    When I have an existing private repo
    And I change it to public
    Then I should see it on my public profile

  @change_to_private
  Scenario: Change from public repo to private
    Given I am logged in
    When I have an existing public repo
    And I change it to private 
    Then I should see it on my dashboard
    And I should not see it on my public profile

  @delete_from_admin
  Scenario: Delete from repo admin
    Given I am logged in
    When I have an existing repo
    And I delete the repo from the admin page
    Then I should not see it on my dashboard

  @new_repo_create_message
  Scenario: Add new repo and get usage instructions
    Given I am logged in
    When I add a new private repository
    Then I should see a usage steps since it is new
