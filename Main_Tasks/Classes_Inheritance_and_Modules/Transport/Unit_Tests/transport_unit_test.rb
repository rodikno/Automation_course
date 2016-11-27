require 'test/unit'
require_relative 'unit_tests_helper'
require '../transport'
require '../../Transport/Wheel_Vehicle/wheel_vehicle'
require '../../Transport/Rail_Vehicle/rail_vehicle'
require '../Wheel_Vehicle/car'
require '../Wheel_Vehicle/electric_car'
require '../Rail_Vehicle/train'
require '../../Transport/Wheel_Vehicle/tesla_car'
require '../../Transport/Modules/climate_control'

class TransportUnitTest < Test::Unit::TestCase

  include TransportUnitTestHelper
  include ClimateControl

  def setup
    @distance = 100
    @tesla = TeslaCar.new
  end

  def test_transport
    transport = Transport.new
    mileage = test_drive(transport, @distance)

    assert_equal(Transport, transport.class)
    assert_equal(mileage[:before] + @distance, mileage[:after])
  end

  def test_wheel_vehicle
    vehicle = WheelVehicle.new
    mileage = test_drive(vehicle, @distance)

    assert_equal(Transport, vehicle.class.superclass)
    assert_equal(mileage[:before] + @distance, mileage[:after])
  end

  def test_rail_vehicle
    rail_vehicle = RailVehicle.new
    mileage = test_drive(rail_vehicle, @distance)

    assert_equal(Transport, rail_vehicle.class.superclass)
    assert_equal(mileage[:before] + @distance, mileage[:after])
  end

  def test_car
    car = Car.new
    mileage = test_drive(car, @distance)

    assert_equal(WheelVehicle, car.class.superclass)
    assert_equal(mileage[:before] + @distance, mileage[:after])
  end

  def test_electric_car
    electic_car = ElectricCar.new
    mileage = test_drive(electic_car, @distance)

    assert_equal(Car, electic_car.class.superclass)
    assert_equal(mileage[:before] + @distance, mileage[:after])
  end

  def test_train
    train = Train.new
    mileage = test_drive(train, @distance)

    assert_equal(RailVehicle, train.class.superclass)
    assert_equal(mileage[:before] + @distance, mileage[:after])
  end

  def test_climate_control
    temp = 21
    @tesla.set_onboard_temperature(temp)
    assert_equal(temp, @tesla.onboard_temperature)
  end

end