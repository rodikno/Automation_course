require "../transport"

class WheelVehicle < Transport

  attr_reader :wheels

  def initialize
    super
    @wheels = 4
  end

  def change_wheel
    unscrew_old_wheel
    screw_new_wheel
    puts "Wheel is changed to brand new"
  end

  private
  def unscrew_old_wheel
    puts "Wheel is unscrewed from vehicle"
  end

  def screw_new_wheel
    puts "Wheel is screwed to vehicle"
  end

end