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

Given(/^I am logged in$/) do
  register_user(@user)
end

When(/^I log out$/) do
  find_element_by_class('logout').click
  login_button = find_element_by_class('login')
  @wait.until{login_button.displayed?}
end


Then(/^I am logged out$/) do
  login_button = find_element_by_class('login')
  expect(@driver.current_url).to eql @homepage_url
  expect(login_button.displayed?)
end