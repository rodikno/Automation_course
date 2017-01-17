require 'rspec'
require 'selenium-webdriver'
require 'test/unit'
require 'uri'
require_relative 'our_module'
require_relative 'redmine_user'

class TestFirst < Test::Unit::TestCase

  include RSpec::Matchers
  include OurModule

  def setup
    @driver = Selenium::WebDriver.for :chrome, :switches => %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate --disable-extensions]
    #@driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    @user = RedmineUser.new
    @homepage_url = 'http://demo.redmine.org/'
    @my_account_page_url = 'http://demo.redmine.org/my/account'
  end

  def test_registration
    register_user(@user)
    success_message = find_element_by_id('flash_notice')

    expect(@driver.current_url).to eql @my_account_page_url
    expect(success_message).to be_displayed
  end

  def test_log_out
    register_user(@user)
    find_element_by_class('logout').click
    login_button = find_element_by_class('login')
    @wait.until{login_button.displayed?}

    expect(@driver.current_url).to eql @homepage_url
    expect(login_button).to be_displayed
  end

  def test_log_in
    register_user(@user)
    log_out
    log_in(@user.login, @user.password)

    expect(find_element_by_class('user').text).to eql @user.login
  end

  def test_change_password
    register_user(@user)
    old_password = @user.password
    new_password = Faker::Internet.password

    find_element_by_class('icon-passwd').click
    @wait.until {@driver.current_url == 'http://demo.redmine.org/my/password'}
    find_element_by_name('password').send_keys(old_password)
    find_element_by_name('new_password').send_keys(new_password)
    find_element_by_name('new_password_confirmation').send_keys(new_password)
    find_element_by_name('commit').click

    success_message = find_element_by_id('flash_notice')

    expect(@driver.current_url).to eql @my_account_page_url
    expect(success_message).to be_displayed
  end

  def test_create_project
    register_user(@user)
    project_name = create_project
    project_settings_page_url = "http://demo.redmine.org/projects/#{project_name}/settings"
    @wait.until{find_element_by_id('flash_notice').displayed?}

    expect(@driver.current_url).to eql project_settings_page_url
  end

  def test_open_random_project
    register_user(@user)
    project_name = Faker::Hipster.word.capitalize
    open_random_project(project_name, 3)
    header = find_element_by_xpath("//div[@id='header']/h1")

    expect(header.text).to eql project_name
  end


  def test_create_version
    register_user(@user)
    project_name = create_project
    version_name = "version_" + rand(99999).to_s
    version_page_url = "http://demo.redmine.org/projects/#{project_name}/settings/versions"

    @driver.navigate.to("http://demo.redmine.org/projects/#{project_name}/versions/new?back_url=")
    version_name_input = find_element_by_id('version_name')
    @wait.until{version_name_input.displayed?}
    version_name_input.send_keys(version_name)
    find_element_by_name('commit').click

    expect(@driver.current_url).to eql version_page_url
  end

  def test_create_issue_bug
    register_user(@user)
    create_project
    issue_options = create_issue('bug')

    expect(issue_options[:visible_issue_id]).to eql issue_options[:created_issue_id]
  end

  def test_create_issue_feature
    register_user(@user)
    create_project
    issue_options = create_issue('feature')

    expect(issue_options[:visible_issue_id]).to eql issue_options[:created_issue_id]
  end

  def test_create_issue_support
    register_user(@user)
    create_project
    issue_options = create_issue('support')

    expect(issue_options[:visible_issue_id]).to eql issue_options[:created_issue_id]
  end

  def test_conditional_watch_issue
    register_user(@user)
    project_name = create_project
    random_boolean = [true, false].sample

    random_boolean ? create_issue('bug') : create_issue('support')

    navigate_to "http://demo.redmine.org/projects/#{project_name}/issues"

    issues_list = find_elements_by_class("issue")
    bug_elem = issues_list.find { |issue| issue.find_element(:class, 'tracker').text == "Bug" }

    if bug_elem #checking if at least one bug was found in the list
      bug_id = bug_elem.find_element(:css, ".id > a").text
      navigate_to "http://demo.redmine.org/issues/#{bug_id}"
      watch_icon = find_element_by_css("a.issue-#{bug_id}-watcher")
      @wait.until{watch_icon.displayed?}
      watch_icon.click
    else #if bug wasn't found, we'll create a new one now
      new_bug = create_issue('bug')
      watch_icon = find_element_by_css("a.issue-#{new_bug[:created_issue_id]}-watcher")
      watch_icon.click
    end

    @wait.until{is_issue_watched?}
    expect(is_issue_watched?).to be
    @driver.navigate.refresh
    watchers_list = find_element_by_id("watchers")
    @wait.until{watchers_list.displayed?}
    username_in_watchers_list = find_element_by_css("li.user-#{@user.id}")

    expect(username_in_watchers_list).to be_displayed
  end

  def teardown
    @driver.quit
  end
end