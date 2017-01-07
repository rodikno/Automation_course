Feature: Redmine project tests

  Scenario: Registation positive
    Given I am on the main page
    When I submit the registration form
    Then New user is registered

  Scenario: Logout positive
    Given I am logged in
    When I log out
    Then I am logged out

  Scenario: Login positive
    Given I am on the main page
    When I submit the login form
    Then I am logged in

  Scenario: