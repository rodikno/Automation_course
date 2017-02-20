class ChangePasswordPage
  include PageObject

  page_url 'http://demo.redmine.org/my/password'

  text_field(:old_password, :id => 'password')
  text_field(:new_password, :id => 'new_password')
  text_field(:password_confirmation, :id => 'new_password_confirmation')
  button(:submit, :name => 'commit')


  def change_password(old_pw, new_pw)
    self.old_password = old_pw
    self.new_password = new_pw
    self.password_confirmation = new_pw
    submit
  end
end