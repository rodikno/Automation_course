require "../transport"

class WheelVehicle < Transport

  attr_reader :wheels

  def initialize
    super
    @wheels = 4
  end

end