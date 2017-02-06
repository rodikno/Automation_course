require_relative 'top_menu_section'

class CommonPage
  include PageObject

  page_section(:top_menu, TopMenuSection, id: 'top-menu')

end