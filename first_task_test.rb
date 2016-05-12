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
    assert(@driver.find_element(:id, 'flash_notice'))
  end

  def test_log_out

    register_user

    @driver.find_element(:class, 'logout').click

    @wait.until{@driver.find_element(:class, 'login').displayed?}
    
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

    assert_equal(@driver.current_url, 'http://demo.redmine.org/my/account')
    assert(@driver.find_element(:id, 'flash_notice'))
  end

  def test_create_project
    register_user

    project_name = create_project

    @wait.until{@driver.find_element(:id, 'flash_notice').displayed?}

    assert_equal("http://demo.redmine.org/projects/#{project_name}/settings", @driver.current_url)
  end


  def test_create_version

    register_user
    project_name = create_project

    version_name = "version_" + rand(99999).to_s

    @driver.find_element(:id, 'tab-versions').click
    @driver.find_element(:xpath, '//a[.=\'New version\']').click

    @driver.find_element(:id, 'version_name').send_keys(version_name)
    @driver.find_element(:name, 'commit').click

    ###MAYBE insert wait here

    assert_equal("http://demo.redmine.org/projects/#{project_name}/settings/versions", @driver.current_url)
  end

  def test_create_issue_bug

    issue_name = create_issue('bug')

    @wait.until{@driver.find_element(:xpath, "//a[@title='#{issue_name}']").displayed?}

    issue_url_slug = @driver.find_element(:xpath, "//a[@title='#{issue_name}']").attribute("href").split('/').last
    current_url_slug = @driver.current_url.split('/').last

    assert_equal(issue_url_slug, current_url_slug)
  end

  def test_create_issue_feature

    issue_name = create_issue('feature')

    @wait.until{@driver.find_element(:xpath, "//a[@title='#{issue_name}']").displayed?}

    issue_url_slug = @driver.find_element(:xpath, "//a[@title='#{issue_name}']").attribute("href").split('/').last
    current_url_slug = @driver.current_url.split('/').last

    assert_equal(issue_url_slug, current_url_slug)
  end

  def test_create_issue_support

    issue_name = create_issue('support')

    @wait.until{@driver.find_element(:xpath, "//a[@title='#{issue_name}']").displayed?}

    issue_url_slug = @driver.find_element(:xpath, "//a[@title='#{issue_name}']").attribute("href").split('/').last
    current_url_slug = @driver.current_url.split('/').last

    assert_equal(issue_url_slug, current_url_slug)
  end

  def teardown
    @driver.quit
  end
end