require 'selenium-webdriver'
require 'require_all'

require_all './pages/**/*.rb'
require_all './helpers/**/*.rb'

Before do
  @browser = Selenium::WebDriver.for :chrome, :switches => %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate --disable-extensions]
  @wait = Selenium::WebDriver::Wait.new(:timeout => 10)

  @user = RedmineUser.new
  @project = RedmineProject.new
  @issue = RedmineIssue.new
end

After do
  @browser.quit if @browser
end