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

  def test_hover_first

    navigate_to "https://the-internet.herokuapp.com/hovers"
    #@driver.navigate.to 'https://the-internet.herokuapp.com/hovers'

    user_avatar = find_element_by_css('.figure')
    link_to_profile = find_element_by_css("a[href='/users/1']")

    @driver.action.move_to(user_avatar).perform

    assert(link_to_profile.displayed?)
  end

  def test_hover_second

    @driver.navigate.to 'https://the-internet.herokuapp.com/hovers'

    user_avatar = find_element_by_css('.figure + .figure')
    link_to_profile = find_element_by_css("a[href='/users/2']")

    @driver.action.move_to(user_avatar).perform

    assert(link_to_profile.displayed?)
  end

  def test_hover_third

    @driver.navigate.to 'https://the-internet.herokuapp.com/hovers'

    user_avatar = find_element_by_css('.figure + .figure')
    link_to_profile = find_element_by_css("a[href='/users/3']")

    @driver.action.move_to(user_avatar).perform

    assert(link_to_profile.displayed?)
  end

  def teardown
    @driver.quit
  end
end