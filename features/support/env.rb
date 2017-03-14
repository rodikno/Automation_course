require './helpers/redmine_helper'
require 'page-object'
require 'factory_girl'
require 'allure-cucumber'

World(PageObject::PageFactory, FactoryGirl::Syntax::Methods, AllureCucumber::DSL, RedmineHelper)
