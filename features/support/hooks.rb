require 'selenium-webdriver'

Before do
  @driver = Selenium::WebDriver.for :chrome, :switches => %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate --disable-extensions]
  @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  @user = initialize_user
  @project = {name: nil}
  @homepage_url = 'http://demo.redmine.org/'
  @my_account_page_url = 'http://demo.redmine.org/my/account'
end

After do
  @driver.quit if @driver
end