require_relative "transport"
require_relative "wheel_vehicle"
require_relative "car"


class CombustionEngineCar < Car
  def initialize
    @engine_type = :combustion
    @transmission = :manual
  end

end

car = CombustionEngineCar.new

car.drive(150)
car.refuel(20, :gasoline)