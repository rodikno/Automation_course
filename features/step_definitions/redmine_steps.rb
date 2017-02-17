Given(/^I am on the main page$/) do
  navigate_to(@homepage_url)
end

When(/^I submit the registration form$/) do
  register_user(@user)
end

Then(/^New user is registered$/) do
  success_message = find_element_by_id('flash_notice')

  expect(@driver.current_url).to eql @my_account_page_url
  expect(success_message).to be_displayed
end

Then(/^I am logged in$/) do
  expect(find_element_by_class('user').text).to eql @user.login
end

When(/^I log out$/) do
  log_out
end


Then(/^I am logged out$/) do
  login_button = find_element_by_class('login')
  expect(@driver.current_url).to eql @homepage_url
  expect(login_button).to be_displayed
end


Given(/^I register a user$/) do
  visit(RegistrationPage).register_user(@user)
end

And(/^I log in$/) do
  log_in(@user.login, @user.password)
end

When(/^I change password$/) do
  @user.password = change_password(@user)
end

Then(/^Success message displayed$/) do
  success_message = find_element_by_id('flash_notice')
  expect(success_message).to be_displayed
end


And(/^I can login with a new password$/) do
  log_out
  log_in(@user.login, @user.password)
end

When(/^I create a project$/) do
  @project[:name] = create_project
  @wait.until{find_element_by_id('flash_notice').displayed?}
end

Then(/^Project details page is displayed$/) do
  project_settings_page_url = "http://demo.redmine.org/projects/#{@project[:name]}/settings"
  expect(@driver.current_url).to eql project_settings_page_url
end

When(/^I try to open random project with (\d+) retries$/) do |retries_count|
  @project[:name] = Faker::Hipster.word.capitalize
  open_random_project(@project[:name], retries_count.to_i)
end

Then(/^Desired project is created$/) do
  header = find_element_by_xpath("//div[@id='header']/h1")
  expect(header.text).to eql @project[:name]
end

And(/^I create a version$/) do
  create_version(@project[:name])

end

Then(/^Version settings page is displayed$/) do
  version_page_url = "http://demo.redmine.org/projects/#{@project[:name]}/settings/versions"
  expect(@driver.current_url).to eql version_page_url
end

And(/^I create a '(.+)' issue$/) do |issue_type|
  issue = create_issue(issue_type)
  reset_hash(@issue)
  @issue = issue
end

And(/^I create a '(.+)' issue if it wasn't created$/) do |issue_type|
  @issue = create_issue(issue_type) unless @issue[:type].eql? issue_type
end

And(/^I create a random issue$/) do
  issue = create_random_issue
  reset_hash(@issue)
  @issue = issue
end

And(/^I start watching the issue$/) do
  start_watching_issue(@issue)
end

Then(/^Issue details page is displayed$/) do
  issue_url = "http://demo.redmine.org/issues/#{@issue[:real_id]}"
  expect(@driver.current_url).to eql issue_url
end


And(/^Success message is shown with correct issue id$/) do
  expect(@issue[:visible_id]).to eql @issue[:real_id]
end


Then(/^I see my user in the list of issue watchers$/) do
  @wait.until{is_issue_watched?}
  @driver.navigate.refresh
  watchers_list = find_element_by_id("watchers")
  @wait.until{watchers_list.displayed?}
  username_in_watchers_list = find_element_by_css("li.user-#{@user.id}")

  expect(username_in_watchers_list).to be_displayed
end