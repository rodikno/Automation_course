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

end