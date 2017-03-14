require 'allure-rspec'
require 'pathname'
require 'factory_girl'
require 'page-object'
require 'rspec'
require 'rspec_junit_formatter'
require 'require_all'

require_all './pages/**/*.rb'
require_all './spec/shared/**/*.rb'
require_all './helpers/**/*.rb'

require './Main_Tasks/Object_Class_Method_Variable/trello_board'
require './Main_Tasks/Object_Class_Method_Variable/trello_user'
require './Main_Tasks/Object_Class_Method_Variable/trello_card'
require './Main_Tasks/Object_Class_Method_Variable/trello_comment'

RSpec.configure do |config|

  config.include RedmineHelper
  config.include PageObject::PageFactory
  config.include FactoryGirl::Syntax::Methods
  config.include AllureRSpec::Adaptor

  config.before(:suite) do
    FactoryGirl.find_definitions
  end

  config.before :all do
    @browser = Selenium::WebDriver.for :chrome, :switches => %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate --disable-extensions]
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  config.after :all do
    @browser.quit
  end
end

AllureRSpec.configure do |c|
  c.output_dir = "reports/allure/"
  c.logging_level= Logger::INFO
end