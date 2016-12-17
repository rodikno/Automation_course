require_relative 'our_module'
require 'selenium-webdriver'
require 'faker'

class RedmineProject

  include OurModule

  attr_reader :name

  def initialize
    @name = 'rodioba_' + Faker::Hipster.word
  end

end