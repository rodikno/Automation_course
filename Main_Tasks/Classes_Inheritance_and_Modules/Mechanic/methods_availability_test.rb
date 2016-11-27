require 'test/unit'
require_relative 'mechanic'

class MethodsAvailabilityTest < Test::Unit::TestCase

  def setup
    @john = Mechanic.new(35, true)
    @simon = Mechanic.new(27, false)
  end

  def test_public_method
    assert(@john.respond_to? :say_swear)
  end

  def test_private_method
    assert_false(@john.respond_to? :get_random_swear)
  end

  def test_protected_method
    #So let's ask Simon about how much Vodka he can drink at once
    #Please remember: you can get this info only if you're a mechanic too
    what_john_knows_about_simon = @john.send(:how_much_drinks, @simon)
    # I've created private method to get the same property directly just to get something to assert
    what_simon_knows_about_himself = @simon.send(:alcohol_max_consumption)

    assert_equal(what_simon_knows_about_himself, what_john_knows_about_simon)
  end
end