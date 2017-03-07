require 'selenium-webdriver'
require 'faker'

class RedmineUser

  attr_reader :first_name, :last_name, :full_name, :login, :email
  attr_accessor :password, :id

  def initialize(opts={})
    @first_name = opts[:first_name] || Faker::Name.first_name
    @last_name = opts[:last_name]   || Faker::Name.last_name
    @login = opts[:login]           || Faker::Internet.user_name("#{@first_name} #{@last_name}", %w(. _ -)) + rand(1000).to_s
    @password = opts[:password]     || Faker::Internet.password
    @email = opts[:email]           || Faker::Internet.safe_email(@login)
    @id = opts[:id]                 || nil
    @full_name = @first_name + ' ' + @last_name
  end

end