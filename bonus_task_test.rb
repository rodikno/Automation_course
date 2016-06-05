require 'test/unit'
require 'selenium-webdriver'
require_relative 'bonus_task_helpers'
require_relative 'our_module'
require 'uri'

class TestFirst < Test::Unit::TestCase

  include BonusTaskHelpers
  include OurModule

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  def test_hover

    link_to_profile = hover_on_avatar_of_user 1
    assert(link_to_profile.displayed?)

    link_to_profile = hover_on_avatar_of_user 2
    assert(link_to_profile.displayed?)

    link_to_profile = hover_on_avatar_of_user 3
    assert(link_to_profile.displayed?)

  end

  def teardown
    @driver.quit
  end
end