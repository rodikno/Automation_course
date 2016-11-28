
class Actions

  def self.touch(vehicle)
    vehicle.when_touched
  end

  def self.connect_wifi(vehicle)
    vehicle.connect_wifi
  end

  def self.disconnect_wifi(vehicle)
    vehicle.disconnect_wifi
  end

end