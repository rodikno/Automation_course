class LoginPage
  include PageObject

  page_url 'http://demo.redmine.org/login'

  text_field(:login, :id => 'username')
  text_field(:password, :id => 'password')
  button(:submit, :name => 'login')

  def log_in(user)
    self.login = user.login
    self.password = user.password
    submit
  end
end