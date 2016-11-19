require '../transport'
require '../../Transport/Wheel_Vehicle/wheel_vehicle'

module TransportUnitTestHelper

  def create_transport
    Transport.new
  end

  def create_wheel_vehicle
    WheelVehicle.new
  end

  def test_drive(object, distance)
    mileage_before = object.mileage
    object.drive(distance)
    mileage_after = object.mileage
    results = {:before => mileage_before, :after => mileage_after}
  end

end