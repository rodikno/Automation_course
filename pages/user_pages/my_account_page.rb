
class MyAccountPage < BasicPage
  include PageObject

  page_url 'http://demo.redmine.org/my/account'

  div(:success_message, :id => 'flash_notice')
  link(:change_password, :css => 'a.icon.icon-passwd')
  text_field(:first_name, :id => 'user_firstname')
  text_field(:last_name, :id => 'user_lastname')
  text_field(:email, :id => 'user_mail')
  select_list(:language, :id => 'user_language')
  button(:save, :name => 'commit')


end