require 'test/unit'
require 'selenium-webdriver'
require_relative 'our_module'
require 'uri'

class TestFirst < Test::Unit::TestCase

  include OurModule

  def setup
    @driver = Selenium::WebDriver.for :chrome, :switches => %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate]
    #@driver = Selenium::WebDriver.for :firefox
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
    user = register_user

    log_out
    log_in(user[:login], user[:password])

    assert_equal(user[:login], find_element_by_class('user').text)
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
    assert (find_element_by_id('flash_notice').displayed?)
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
    register_user
    create_project
    issue_options = create_issue('bug')

    assert_equal(issue_options[:visible_issue_id], issue_options[:created_issue_id])
  end

  def test_create_issue_feature
    register_user
    create_project
    issue_options = create_issue('feature')

    assert_equal(issue_options[:visible_issue_id], issue_options[:created_issue_id])
  end

  def test_create_issue_support
    register_user
    create_project
    issue_options = create_issue('support')

    assert_equal(issue_options[:visible_issue_id], issue_options[:created_issue_id])
  end

  def test_conditional_create_issue
    user = register_user
    project_name = create_project
    random_boolean = [true, false].sample

    if random_boolean
      create_issue('bug')
    end

    navigate_to "http://demo.redmine.org/projects/#{project_name}/issues"

    issue_types_list = find_elements_by_class("tracker")
    issue_ids_list = find_elements_by_css("td.id > *:first-child")
    issue_id_found = String.new

    issue_types_list.each_with_index do |elem, index|
      if elem.text == "Bug"
        issue_id_found = issue_ids_list[index].text
        navigate_to "http://demo.redmine.org/issues/#{issue_id_found}"
        watch_icon = find_element_by_css("a.issue-#{issue_id_found}-watcher")
        @wait.until{watch_icon.displayed?}
        watch_icon.click
        break
      end
    end

    if issue_id_found.empty?
      new_bug = create_issue('bug')
      watch_icon = find_element_by_css("a.issue-#{new_bug[:created_issue_id]}-watcher")
      watch_icon.click
    end
    
    @wait.until{is_issue_watched?}
    assert(is_issue_watched?)
    @driver.navigate.refresh
    @wait.until{find_element_by_id("watchers").displayed?}
    assert(find_element_by_css("li.user-#{user[:user_id]}").displayed?)
  end

  def teardown
    @driver.quit
  end
end