module OurModule

  def register_user
    @driver.navigate.to 'http://demo.redmine.org'
    @driver.find_element(:class, 'register').click


    @wait.until {@driver.find_element(:id, 'user_login').displayed?}

    user_login = ('login' + rand(99999).to_s)
    password = 's0meP@ssw0rd'
    firstname = 'George'
    lastname = 'Aobumeyang'
    user_email = user_login + 'myuser@xxx.com'

    @driver.find_element(:id, 'user_login').send_keys user_login
    @driver.find_element(:id, 'user_password').send_keys password
    @driver.find_element(:id, 'user_password_confirmation').send_keys password
    @driver.find_element(:id, 'user_firstname').send_keys firstname
    @driver.find_element(:id, 'user_lastname').send_keys lastname
    @driver.find_element(:id, 'user_mail').send_keys user_email

    @driver.find_element(:name, 'commit').click
  end

  def log_out
    @driver.find_element(:class, 'logout').click
  end

  def log_in(login, password)
    @driver.find_element(:class, 'login').click
    @driver.find_element(:name, 'username').send_keys(login)
    @driver.find_element(:name, 'password').send_keys(password)
    @driver.find_element(:name,'login').click
  end
end