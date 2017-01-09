Feature: Redmine project tests

  Scenario: Registation positive
    Given I am on the main page
    When I submit the registration form
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