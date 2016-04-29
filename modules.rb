module OurModule
  def register_user
    @driver.navigate.to 'http://demo.redmine.org'
    @driver.find_element(:class, 'register').click


    @wait.until {@driver.find_element(:id, 'user_login').displayed?}

    login = ('login' + rand(99999).to_s)

    @driver.find_element(:id, 'user_login').send_keys (login + 'dflilukufs')
    @driver.find_element(:id, 'user_password').send_keys 'dfdsfdffs'
    @driver.find_element(:id, 'user_password_confirmation').send_keys 'dfdsfdffs'
    @driver.find_element(:id, 'user_firstname').send_keys 'dfdsfdffs'
    @driver.find_element(:id, 'user_lastname').send_keys 'dfdsfdffs'
    @driver.find_element(:id, 'user_mail').send_keys(login + 'dfdhfs@com.ua')

    @driver.find_element(:name, 'commit').click
  end
end