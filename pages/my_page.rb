class MyPage
  include PageObject

  page_url 'http://demo.redmine.org/my/page'

  page_section(:top_menu, TopMenuSection, :id => 'top-menu')
end