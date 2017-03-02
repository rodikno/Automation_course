require 'page-object'

class BasicPage
  include PageObject

  BASIC_URL = 'http://demo.redmine.org'

  div(:success_message, :id => 'flash_notice')
  link(:log_out, :css => '.logout')
  link(:user_link, :css => '#loggedas a')

  def has_success_message?
    self.success_message_element.visible?
  end

  def get_current_user_id
    user_link_element.when_present.attribute('href').split('/').last
  end

end