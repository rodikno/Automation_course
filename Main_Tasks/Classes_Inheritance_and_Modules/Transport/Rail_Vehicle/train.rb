require '../../Transport/Rail_Vehicle/rail_vehicle'

class Train < RailVehicle
  def initialize
    super
    @wagons = 5
    @departure_city = "Kiev"
    @arrival_city = "Lviv"
    @places_total = 250
    @places_available = 10
  end
end