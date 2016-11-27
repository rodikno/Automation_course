require_relative 'wheel_vehicle'

class Car < WheelVehicle

  attr_reader :seats

  def initialize
    super
    @seats = 4
  end
end