class Vehicle

  attr_reader :wheels, :engine_type, :gear, :seats, :fuel, :fuel_consumption, :mileage

  def initialize
    @wheels = 4
    @engine_type = :combustion
    @gear = :manual
    @seats = 4
    @fuel_type = :gasoline
    @fuel = 250
    @fuel_consumption = 10.0
    @mileage = 0
  end

  def drive(distance)
    puts "Driving..."
    consumed_fuel = count_fuel_consumed(distance)
    if @fuel == 0 or consumed_fuel > @fuel
      puts "You don't have enough fuel to drive, please refuel the vehicle"
    else
      @fuel -= consumed_fuel
      @mileage += distance
      puts "Distance passed: #{distance}"
      puts "Fuel consumed: #{consumed_fuel}"
      puts "Fuel left: #{fuel}"
    end
  end

  def refuel(quantity, fuel_type)
    if fuel_type == @fuel_type
      @fuel += quantity
      puts "Vehicle refueled with #{quantity} of #{fuel_type.to_s}"
      puts "Fuel left in total: #{@fuel}"
    else
      puts "Please choose correct fuel type for this vehicle"
    end
  end

  private
  def count_fuel_consumed(distance)
    fuel_consumed = (@fuel_consumption/100)*distance
  end

end

mycar = Vehicle.new
mycar.drive(100)
mycar.refuel(10, :gasoline)