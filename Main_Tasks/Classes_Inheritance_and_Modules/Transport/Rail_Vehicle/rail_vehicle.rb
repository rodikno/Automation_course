require '../transport'

class RailVehicle < Transport

  def initialize
    super
    @payload_type = :passenger
  end

end