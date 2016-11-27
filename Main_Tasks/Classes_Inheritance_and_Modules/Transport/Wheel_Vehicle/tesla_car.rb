require_relative 'electric_car'

class TeslaCar < ElectricCar

  def initialize
    super
    @color = :red
    @max_speed = 250
    @price = 110000
  end

end