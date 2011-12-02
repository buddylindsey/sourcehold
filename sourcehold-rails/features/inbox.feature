Feature: Message System
  So the user can have and send messages
  As a user
  I want to be able to spend and recieve messages

  Scenario: Send a message to another user
    Given I am logged in
    And Someone else is available
    When I send a message
    Then I should see it as a sent message

  Scenario: Recieve a message from another user
    Given I am logged in
    And I sign out
    And Someone else is available
    And They send me a message
    When I log in
    And I recieve a message
    Then I should see the message in a stream in my inbox

  Scenario: Reply to a message
    Given I am logged in
    And I sign out
    And Someone else is available
    And They send me a message
    When I log in
    And I view a message
    And I reply to that message
    Then I should see both messages on the same page
