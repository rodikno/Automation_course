Feature: Redmine project tests

  Scenario: Registration positive
    Given I register a user
    Then New user is registered

  Scenario: Logout positive
    Given I register a user
    When I log out
    Then I am logged out

  Scenario: Login positive
    Given I register a user
    When I log out
    And I log in
    Then I am logged in

  Scenario: Change password positive
    Given I register a user
    When I change password
    Then Success message displayed
    And I can login with a new password

  Scenario: Create project positive
    Given I register a user
    When I create a project
    Then Project details page is displayed