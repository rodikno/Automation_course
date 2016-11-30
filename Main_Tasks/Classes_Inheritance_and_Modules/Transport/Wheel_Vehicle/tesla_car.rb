require_relative 'electric_car'
require '../../Transport/Modules/climate_control'

class TeslaCar < ElectricCar

  include ClimateControl

  attr_reader :seats, :color, :max_speed, :price
  attr_accessor :onboard_temperature

  def initialize
    super
    @seats = 4
    @color = :red
    @max_speed = 250
    @price = 110000
    @onboard_temperature
  end

end