class CommonPage
  include PageObject

  page_section(:top_menu, TopMenuSection, id: 'top-menu')

end