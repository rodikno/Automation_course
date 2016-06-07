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

  def test_keypress

    navigate_to('https://the-internet.herokuapp.com/key_presses')

    page = find_element_by_css('body')
    @driver.action.send_keys(page, :enter).perform

    keypress_indicator = find_element_by_id('result')
    expected_text = 'ENTER'

    assert(keypress_indicator.text.include?(expected_text))

  end

  def test_jquery_ui_menu

    navigate_to 'https://the-internet.herokuapp.com/jqueryui/menu'

    jquery_menu_1st_level = find_element_by_id('ui-id-3')
    jquery_menu_2nd_level = find_element_by_id('ui-id-4')
    jquery_menu_3rd_level_pdf = find_element_by_id('ui-id-5')

    multilevel_menu = [jquery_menu_1st_level, jquery_menu_2nd_level, jquery_menu_3rd_level_pdf]

    multilevel_menu.each do |menu|
      wait_until_displayed(menu)
      mouse_move_to(menu)
    end

    assert(multilevel_menu.last.displayed?)

  end

  def test_iframe_functionality

    navigate_to 'https://the-internet.herokuapp.com/iframe'

    frame_body = find_element_by_id('mceu_13-body')
    bold_button = find_element_by_id('mceu_3')
    textbox_iframe_id = 'mce_0_ifr'


    wait_until_displayed(frame_body)

    #switch to textbox iframe and select all
    @driver.switch_to.frame(textbox_iframe_id)
    text_box = find_element_by_css('#tinymce>p')
    move_to_and_click(text_box)
    @driver.action.send_keys(text_box, [:control, 'a']).perform

    #switch back to main window and make text bold
    @driver.switch_to.default_content
    move_to_and_click(bold_button)

    #back to iframe and verify text made bold (strong)
    @driver.switch_to.frame(textbox_iframe_id)
    strong_tag_around_text = find_element_by_css('#tinymce>p>strong')

    assert(strong_tag_around_text.displayed?)
  end

  def teardown
    @driver.quit
  end
end