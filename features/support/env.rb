require './helpers/redmine_helper'
require 'page-object'
require 'factory_girl'

World(PageObject::PageFactory, FactoryGirl::Syntax::Methods, RedmineHelper)
