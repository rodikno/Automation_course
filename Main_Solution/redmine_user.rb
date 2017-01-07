require 'selenium-webdriver'
require 'faker'

class RedmineUser

  attr_reader :login, :password, :first_name, :last_name, :email
  attr_accessor :id

  def initialize
    @first_name = Faker::Name.first_name
    @last_name = Faker::Name.last_name
    @login = Faker::Internet.user_name("#{@first_name} #{@last_name}", %w(. _ -))
    @password = Faker::Internet.password
    @email = Faker::Internet.safe_email(@user_login)
    @id = nil
  end

end