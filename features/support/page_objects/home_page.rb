require_relative 'top_menu_section'

class HomePage
  include PageObject

  page_url 'http://demo.redmine.org/'

  page_section(:top_menu, TopMenuSection, id: 'top-menu')
end