
class RegistrationPage < BasicPage
  include PageObject

  page_url BASIC_URL + '/account/register'

  text_field(:login, :id => 'user_login')
  text_field(:password, :id => 'user_password')
  text_field(:confirmation, :id => 'user_password_confirmation')
  text_field(:first_name, :id => 'user_firstname')
  text_field(:last_name, :id => 'user_lastname')
  text_field(:email, :id => 'user_mail')
  select_list(:language, :id => 'user_language')
  button(:submit, :name => 'commit')

  def register_user(user)
    self.login = user.login
    self.password = user.password
    self.confirmation = user.password
    self.first_name = user.first_name
    self.last_name = user.last_name
    self.email = user.email
    self.submit
    user.id = get_current_user_id
  end

end