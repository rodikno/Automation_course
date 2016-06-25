module BonusTaskHelpers

  def navigate_to(url)
    @driver.navigate.to(url)
  end

  def hover_on_avatar_of_user(user_number)

    navigate_to "https://the-internet.herokuapp.com/hovers"
    link_to_profile = find_element_by_css("a[href='/users/#{user_number.to_s}']")

    case user_number
      when 1
        user_avatar = find_element_by_css('.figure')
      when 2
        user_avatar = find_element_by_css('.figure + .figure')
      when 3
        user_avatar = find_element_by_css('.figure + .figure + .figure')
      else
        raise 'Not available user specified'
    end

    @driver.action.move_to(user_avatar).perform
    link_to_profile
  end

  def html5_drag_and_drop(source_element_id, target_element_id)
    #Selenium cannot perform HTML5 D&D
    #and it's an opened issue in Selenium bug tracker
    #https://github.com/SeleniumHQ/selenium-google-code-issue-archive/issues/3604

    source_element = find_element_by_css(source_element_id)
    target_element = find_element_by_css(target_element_id)


    #using jQuery HTML5 D&D simulator as a hack
    drag_and_drop_js = File.read(Dir.pwd + '/drag_and_drop_helper.js')
    @driver.execute_script(drag_and_drop_js + "$('#{source_element_id}').simulateDragDrop({ dropTarget: '#{target_element_id}'});")


    {:source_element => source_element, :target_element => target_element}
  end

  def select_option_from_dropdown(string_dropdown_id, string_option_value)

    my_select = Selenium::WebDriver::Support::Select.new(find_element_by_id(string_dropdown_id))
    my_select.select_by(:value, string_option_value)

    selected_option_value = my_select.selected_options[0].attribute('value')
  end

  def mouse_move_to(element)
    @driver.action.move_to(element).perform
  end

  def move_to_and_click(element)
    @driver.action.move_to(element).click.perform
  end

  def wait_until_displayed(element)
    @wait.until{element.displayed?}
  end

end