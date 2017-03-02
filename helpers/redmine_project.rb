require 'faker'

class RedmineProject

  attr_reader :name, :description

  def initialize
    @name = Faker::Hacker.noun + rand(1000).to_s
    @description = Faker::Lorem.sentence 5
  end

end