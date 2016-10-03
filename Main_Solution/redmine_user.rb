require_relative 'our_module'
require 'selenium-webdriver'
require 'faker'

class RedmineUser

  include OurModule

  attr_reader :user_id, :user_login, :password, :first_name, :last_name, :user_email

  def initialize
    @driver = Selenium::WebDriver.for :chrome, :switches => %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate]
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)

    @first_name = Faker::Name.first_name
    @last_name = Faker::Name.last_name
    @user_login = Faker::Internet.user_name("#{@first_name} #{@last_name}", %w(. _ -))
    @password = Faker::Internet.password
    @user_email = Faker::Internet.safe_email(@user_login)

    @driver.navigate.to 'http://demo.redmine.org'
    find_element_by_class('register').click

    @wait.until {find_element_by_id('user_login').displayed?}

    find_element_by_id('user_login').send_keys @user_login
    find_element_by_id('user_password').send_keys @password
    find_element_by_id('user_password_confirmation').send_keys @password
    find_element_by_id('user_firstname').send_keys @first_name
    find_element_by_id('user_lastname').send_keys @last_name
    find_element_by_id('user_mail').send_keys @user_email

    find_element_by_name('commit').click
    @user_id = find_element_by_css('div#loggedas>a').attribute('href').split('/').last
  end
end