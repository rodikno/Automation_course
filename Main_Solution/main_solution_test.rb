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
    expect(success_message.displayed?).to be
  end

  def test_log_out
    register_user(@user)
    find_element_by_class('logout').click
    login_button = find_element_by_class('login')
    @wait.until{login_button.displayed?}

    expect(@driver.current_url).to eql @homepage_url
    expect(login_button.displayed?)
  end

  def test_log_in
    register_user(@user)
    log_out
    log_in(@user.login, @user.password)

    expect(find_element_by_class('user').text).to eql @user.login
  end

  def test_change_password
    register_user(@user)
    change_password(@user)

    success_message = find_element_by_id('flash_notice')

    expect(@driver.current_url).to eql @my_account_page_url
    expect(success_message.displayed?).to be
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
    create_version(project_name)

    version_page_url = "http://demo.redmine.org/projects/#{project_name}/settings/versions"
    expect(@driver.current_url).to eql version_page_url
  end

  def test_create_issue_bug
    register_user(@user)
    create_project
    issue_options = create_issue('bug')

    expect(issue_options[:visible_id]).to eql issue_options[:real_id]
  end

  def test_create_issue_feature
    register_user(@user)
    create_project
    issue_options = create_issue('feature')

    expect(issue_options[:visible_id]).to eql issue_options[:real_id]
  end

  def test_create_issue_support
    register_user(@user)
    create_project
    issue_options = create_issue('support')

    expect(issue_options[:visible_id]).to eql issue_options[:real_id]
  end

  def test_conditional_watch_issue
    register_user(@user)
    project_name = create_project
    issue = create_random_issue

    navigate_to "http://demo.redmine.org/projects/#{project_name}/issues"

    if is_issue_a_bug?(issue)
      issue_id = issue[:real_id]
      navigate_to "http://demo.redmine.org/issues/#{issue_id}"
      start_watching_issue(issue)
    else
      new_bug = create_issue('bug')
      start_watching_issue(new_bug)
    end

    @wait.until{is_issue_watched?}
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