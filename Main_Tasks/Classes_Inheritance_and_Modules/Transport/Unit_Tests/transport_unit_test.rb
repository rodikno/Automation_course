require 'test/unit'
require_relative 'unit_tests_helper'


class TransportUnitTest < Test::Unit::TestCase

  include TransportUnitTestHelper

  def setup
    @distance = 100
  end

  def test_drive_transport
    transport = create_transport
    mileage = test_drive(transport, @distance)

    assert_equal(mileage[:before] + @distance, mileage[:after])
  end

  def test_drive_wheel_vehicle
    vehicle = create_wheel_vehicle
    mileage = test_drive(vehicle, @distance)

    assert_equal(mileage[:before] + @distance, mileage[:after])
  end

end