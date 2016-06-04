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

  def teardown
    @driver.quit
  end
end