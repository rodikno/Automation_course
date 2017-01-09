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