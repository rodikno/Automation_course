require 'factory_girl'
require 'rspec'
require 'page-object'
require 'require_all'

require './Main_Tasks/Object_Class_Method_Variable/trello_board'
require './Main_Tasks/Object_Class_Method_Variable/trello_user'
require './Main_Tasks/Object_Class_Method_Variable/trello_card'
require './Main_Tasks/Object_Class_Method_Variable/trello_comment'

RSpec.configure do |config|
  config.include PageObject::PageFactory
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
  # config.before :all do
  #   @browser = Selenium::WebDriver.for :chrome, :switches => %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate --disable-extensions]
  #   @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  # end

  # config.after :all do
  #   @browser.quit
  # end
end