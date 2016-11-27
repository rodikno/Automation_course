require 'test/unit'
require_relative 'unit_tests_helper'
require '../transport'
require '../../Transport/Wheel_Vehicle/wheel_vehicle'
require '../../Transport/Rail_Vehicle/rail_vehicle'
require '../Wheel_Vehicle/car'
require '../Wheel_Vehicle/electric_car'
require '../Rail_Vehicle/train'

class TransportUnitTest < Test::Unit::TestCase

  include TransportUnitTestHelper

  def setup
    @transport = Transport.new
    @wheel_vehicle = WheelVehicle.new
  end

  def test_public_method
    assert(@transport.respond_to? :drive)
  end

  def test_private_method
    assert_false(@transport.respond_to? :count_fuel_consumed)
  end

  def test_public_from_descendant
    assert(@wheel_vehicle.respond_to? :drive)
  end

  def test_private_from_descendant
    assert_false(@wheel_vehicle.respond_to? :count_fuel_consumed)
  end
end