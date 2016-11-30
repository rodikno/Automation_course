require_relative 'car'

class ElectricCar < Car

  def initialize
    super
    @fuel_type = :electricity
    @fuel = 20
    @max_fuel = 25
    @fuel_consumption = 11.5
    @engine_type = :electric
  end
end