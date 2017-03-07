Feature: Redmine project tests

  Background:
    Given I register a user

  @user @registration
  Scenario: [User: Registration] positive
    Then New user is registered

  @user
  Scenario: [User: Logout]
    When I log out
    Then I am logged out

  @user
  Scenario: [User: Login]
    When I log out
    And I log in
    Then I am logged in

  @user
  Scenario: [User: Change password]
    When I change password
    Then My password is changed

  @project
  Scenario: [Project: create]
    When I create a project
    Then Project is created

  @project
  Scenario: [Project: open random one]
    When I try to open random project with 3 retries
    Then Desired project is created

  @project
  Scenario: [Project: Create version]
    When I create a project
    And I create a version
    Then Version settings page is displayed

  @issue
  Scenario Outline: [Issue: Create each of the issue types]
    When I create a project
    And I create a '<issue_type>' issue
    Then Issue is created
    Examples:
      | issue_type |
      | Bug        |
      | Feature    |
      | Support    |

  @issue
  Scenario: [Issue: create issue of a random type and add user to watchers]
    When I create a project
    And I create a random issue
    And I create a 'Bug' issue if it wasn't created
    And I start watching the issue
    Then I see my user in the list of issue watchers
