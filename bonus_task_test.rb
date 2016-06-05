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

  def test_drag_and_drop
    navigate_to 'https://the-internet.herokuapp.com/drag_and_drop'

    source_element_id = '#column-a'
    target_element_id = '#column-b'

    columns_hash = html5_drag_and_drop source_element_id, target_element_id

    assert_equal('B', columns_hash[:source_element].text)
    assert_equal('A', columns_hash[:target_element].text)

  end

  def test_select_from_list

    navigate_to 'https://the-internet.herokuapp.com/dropdown'
    dropdown_id = 'dropdown'
    available_options = ['1', '2']

    available_options.each do |option|
      assert_equal(option, select_option_from_dropdown(dropdown_id, option))
    end

  end

  def teardown
    @driver.quit
  end
end