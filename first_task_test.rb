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

    expected_text = "Your account has been activated. You can now log in."
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  def test_log_out

    register_user

    @driver.find_element(:class, 'logout').click

    sleep 3
    login_button = @driver.find_element(:class, 'login')

    assert(login_button.displayed?)
    assert_equal('http://demo.redmine.org/' ,@driver.current_url)
  end

  def test_log_in
    register_user

    current_username = @driver.find_element(:class, 'user').text

    log_out

    log_in(current_username, 's0meP@ssw0rd')
    assert_equal(current_username, @driver.find_element(:class, 'user').text)
  end

  def test_change_password
    register_user

    @driver.find_element(:class, 'icon-passwd').click
    @wait.until {@driver.current_url == 'http://demo.redmine.org/my/password'}

    @driver.find_element(:name, 'password').send_keys('s0meP@ssw0rd')
    @driver.find_element(:name, 'new_password').send_keys('1234')
    @driver.find_element(:name, 'new_password_confirmation').send_keys('1234')
    @driver.find_element(:name, 'commit').click

    expected_message = "Password was successfully updated."
    actual_message = @driver.find_element(:id, 'flash_notice').text

    assert_equal(expected_message, actual_message)
  end

  def test_create_project
    register_user

    random_number_string = rand(99999).to_s
    project_name = 'rodioba_project_' + random_number_string

    @driver.navigate.to('http://demo.redmine.org/projects')
    @driver.find_element(:css, 'a.icon-add').click

    @wait.until{@driver.current_url == 'http://demo.redmine.org/projects/new'}

    @driver.find_element(:id, 'project_name').send_keys(project_name)
    @driver.find_element(:name, 'commit').click

    @wait.until{@driver.find_element(:id, 'flash_notice').displayed?}

    expected_message = 'Successful creation.'
    actual_message = @driver.find_element(:id, 'flash_notice').text

    assert_equal(expected_message, actual_message)
  end


  def test_create_version
    create_project

    @driver.find_element(:id, 'tab-versions').click
    @driver.find_element(:xpath, '//a[.=\'New version\']').click

    @driver.find_element(:id, 'version_name').send_keys(rand(99999).to_s)
    @driver.find_element(:name, 'commit').click

    expected_message = 'Successful creation.'
    actual_message = @driver.find_element(:id, 'flash_notice').text

    assert_equal(expected_message, actual_message)
  end

  def test_create_issue_bug

    issue_name = create_issue('bug')

    success_message = @driver.find_element(:xpath, "//a[@title='#{issue_name}']/..")
    issue_url_slug = @driver.find_element(:xpath, "//a[@title='#{issue_name}']").attribute("href").split('/').last
    current_url_slug = @driver.current_url.split('/').last

    assert(success_message.text.include?('created'))
    assert_equal(issue_url_slug, current_url_slug)

  end

  def test_create_issue_feature

    issue_name = create_issue('feature')

    success_message = @driver.find_element(:xpath, "//a[@title='#{issue_name}']/..")
    issue_url_slug = @driver.find_element(:xpath, "//a[@title='#{issue_name}']").attribute("href").split('/').last
    current_url_slug = @driver.current_url.split('/').last

    assert(success_message.text.include?('created'))
    assert_equal(issue_url_slug, current_url_slug)

  end

  def test_create_issue_support

    issue_name = create_issue('support')

    success_message = @driver.find_element(:xpath, "//a[@title='#{issue_name}']/..")
    issue_url_slug = @driver.find_element(:xpath, "//a[@title='#{issue_name}']").attribute("href").split('/').last
    current_url_slug = @driver.current_url.split('/').last

    assert(success_message.text.include?('created'))
    assert_equal(issue_url_slug, current_url_slug)
  end

  def teardown
    @driver.quit
  end
end