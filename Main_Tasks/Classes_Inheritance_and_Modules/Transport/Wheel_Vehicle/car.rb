require_relative "wheel_vehicle"

class Car < WheelVehicle

  def initialize
    super
    @seats = 4
  end
end