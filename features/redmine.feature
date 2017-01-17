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

  Scenario: Open random project
    Given I register a user
    When I try to open random project with 3 retries
    Then Desired project is created

  Scenario: Create version
    Given I register a user
    When I create a project
    And I create a version
    Then Version settings page is displayed

  Scenario Outline: Create each of the issue types
    Given I register a user
    When I create a project
    And I create a '<issue_type>' issue
    Then Issue details page is displayed
    And Success message is shown with correct issue id
    Examples:
      | issue_type |
      | bug        |
      | feature    |
      | support    |

  Scenario: Create issue of a random type and add user to watchers
    Given I register a user
    When I create a project
    And I create a random issue
    And I create a 'bug' issue if it wasn't created
    And I start watching the issue
    Then I see my user in the list of issue watchers
