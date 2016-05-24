require 'test/unit'
require 'selenium-webdriver'
require_relative 'our_module'
require 'uri'

class TestFirst < Test::Unit::TestCase

  include OurModule

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  def test_registration

    register_user

    assert_equal(@driver.current_url, 'http://demo.redmine.org/my/account')
    assert(find_element_by_id('flash_notice'))
  end

  def test_log_out

    register_user

    find_element_by_class('logout').click

    login_button = find_element_by_class('login')

    @wait.until{login_button.displayed?}

    assert(login_button.displayed?)
    assert_equal('http://demo.redmine.org/' ,@driver.current_url)
  end

  def test_log_in
    register_user

    current_username = find_element_by_class('user').text

    log_out

    log_in(current_username, 's0meP@ssw0rd')
    assert_equal(current_username, find_element_by_class('user').text)
  end

  def test_change_password
    user = register_user

    old_password = user[:password]
    new_password = 'pass_' + rand(9999).to_s


    find_element_by_class('icon-passwd').click

    @wait.until {@driver.current_url == 'http://demo.redmine.org/my/password'}

    find_element_by_name('password').send_keys(old_password)
    find_element_by_name('new_password').send_keys(new_password)
    find_element_by_name('new_password_confirmation').send_keys(new_password)
    find_element_by_name('commit').click

    assert_equal(@driver.current_url, 'http://demo.redmine.org/my/account')
    assert (find_element_by_id('flash_notice'))
  end

  def test_create_project
    register_user

    project_name = create_project

    @wait.until{find_element_by_id('flash_notice').displayed?}

    assert_equal("http://demo.redmine.org/projects/#{project_name}/settings", @driver.current_url)
  end


  def test_create_version

    register_user
    project_name = create_project

    version_name = "version_" + rand(99999).to_s

    @driver.navigate.to("http://demo.redmine.org/projects/#{project_name}/versions/new?back_url=")

    version_name_input = find_element_by_id('version_name')

    @wait.until{version_name_input.displayed?}

    version_name_input.send_keys(version_name)
    find_element_by_name('commit').click

    assert_equal("http://demo.redmine.org/projects/#{project_name}/settings/versions", @driver.current_url)
  end

  def test_create_issue_bug

    issue_options = create_issue('bug')

    assert_equal(issue_options[:issue_url_slug], issue_options[:created_issue_url_slug])
  end

  def test_create_issue_feature

    issue_options = create_issue('feature')

    assert_equal(issue_options[:issue_url_slug], issue_options[:created_issue_url_slug])
  end

  def test_create_issue_support

    issue_options = create_issue('support')

    assert_equal(issue_options[:issue_url_slug], issue_options[:created_issue_url_slug])
  end

  def teardown
    @driver.quit
  end
end