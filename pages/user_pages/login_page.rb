
class LoginPage < BasicPage
  include PageObject

  page_url BASIC_URL + '/login'

  text_field(:login, :id => 'username')
  text_field(:password, :id => 'password')
  button(:submit, :name => 'login')

  def log_in(user)
    self.login = user.login
    self.password = user.password
    submit
  end
end