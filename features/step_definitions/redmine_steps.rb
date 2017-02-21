Given(/^I am on the main page$/) do
  navigate_to(@homepage_url)
end

When(/^I submit the registration form$/) do
  register_user(@user)
end

Then(/^New user is registered$/) do


  success_message = on(MyAccountPage).success_message_element

  expect(@current_page.page_url_value).to eql on(MyAccountPage).page_url_value
  expect(success_message).to be_visible
end

Then(/^I am logged in$/) do
  active_username = on(MyPage).top_menu.active_user_element.attribute 'text'
  expect(active_username).to eql @user.login
end

When(/^I log out$/) do
  on(TopMenuSection).log_out
end


Then(/^I am logged out$/) do
  login_button = on(HomePage).top_menu.log_in_element

  expect(@current_page.page_url_value).to eql on(HomePage).page_url_value
  expect(login_button).to be_visible
end


Given(/^I register a user$/) do
  visit(RegistrationPage).register_user(@user)
end

And(/^I log in$/) do
  visit(LoginPage).log_in(@user)
end

When(/^I change password$/) do
  new_password = Faker::Internet.password
  visit(ChangePasswordPage).change_password(@user.password, new_password)

  @user.password = new_password
end

Then(/^Success message displayed$/) do
  success_message = on(MyAccountPage).success_message_element
  expect(success_message).to be_visible
end


And(/^I can login with a new password$/) do
  step 'I log out'
  step 'I log in'
  step 'I am logged in'
end

When(/^I create a project$/) do
  @project[:name] = 'rodioba_project_' + rand(99999).to_s
  visit(CreateProjectPage).create_project(@project[:name])
end

When(/^I create a project named '(.+)'$/) do |name|
  @project[:name] = name
  visit(CreateProjectPage).create_project(@project[:name])
end

Then(/^Project details page is displayed$/) do
  on ProjectSettingsPage, :using_params => {:project_name => @project[:name]} do |page|
    expect(page.success_message_element).to be_visible
  end
end

When(/^I try to open random project with (\d+) retries$/) do |retries_count|
  @project[:name] = Faker::Hipster.word.capitalize
  random_project_url = "http://demo.redmine.org/projects/#{@project[:name]}"

  i = 0
  begin
    i += 1
    project_exists?(random_project_url)
  rescue StandardError
    step "I create a project named '#{@project[:name]}'"
    retry if i < retries_count.to_i
  end
end

Then(/^Desired project is created$/) do
  on ProjectSettingsPage, :using_params => {:project_name => @project[:name]} do |page|
    expect(page.project_title).to eql @project[:name]
  end
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