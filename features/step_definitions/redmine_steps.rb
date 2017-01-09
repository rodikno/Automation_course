Given(/^I am on the main page$/) do
  navigate_to(@homepage_url)
end

When(/^I submit the registration form$/) do
  register_user(@user)
end

Then(/^New user is registered$/) do
  success_message = find_element_by_id('flash_notice')

  expect(@driver.current_url).to eql @my_account_page_url
  expect(success_message.displayed?).to be
end

Then(/^I am logged in$/) do
  expect(find_element_by_class('user').text).to eql @user.login
end

When(/^I log out$/) do
  log_out
  # find_element_by_class('logout').click
  # login_button = find_element_by_class('login')
  # @wait.until{login_button.displayed?}
end


Then(/^I am logged out$/) do
  login_button = find_element_by_class('login')
  expect(@driver.current_url).to eql @homepage_url
  expect(login_button.displayed?)
end


Given(/^I register a user$/) do
  register_user(@user)
end

And(/^I log in$/) do
  log_in(@user.login, @user.password)
end

When(/^I change password$/) do
  @user.password = change_password(@user)
end

Then(/^Success message displayed$/) do
  success_message = find_element_by_id('flash_notice')
  expect(success_message.displayed?).to be
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