class TopMenuSection
  include PageObject

  link(:log_in, :css => 'a.login')
  link(:log_out, :css => 'a.logout')
  link(:register, :css => 'a.register')
  link(:my_account, :css => 'a.my-account')
  link(:active_user, :css => 'div#loggedas > a.user.active')
end