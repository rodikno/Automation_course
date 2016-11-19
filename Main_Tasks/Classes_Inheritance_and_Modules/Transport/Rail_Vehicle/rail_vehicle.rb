require_relative "transport"

class RailVehicle < Transport

  def initialize
    @payload_type = :passenger
  end

end