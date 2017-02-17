Feature: Redmine project tests

  Scenario: My Debugging Scenario
    Given I register a user

  Scenario: Registration positive
    Then New user is registered

  Scenario: Logout positive
    When I log out
    Then I am logged out

  Scenario: Login positive
    When I log out
    And I log in
    Then I am logged in

  Scenario: Change password positive
    When I change password
    Then Success message displayed
    And I can login with a new password

  Scenario: Create project positive
    When I create a project
    Then Project details page is displayed

  Scenario: Open random project
    When I try to open random project with 3 retries
    Then Desired project is created

  Scenario: Create version
    When I create a project
    And I create a version
    Then Version settings page is displayed

  Scenario Outline: Create each of the issue types
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
    When I create a project
    And I create a random issue
    And I create a 'bug' issue if it wasn't created
    And I start watching the issue
    Then I see my user in the list of issue watchers
