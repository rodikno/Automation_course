
module ClimateControl

  def set_onboard_temperature(temperature)
    if self.respond_to?(:onboard_temperature=)
      self.onboard_temperature = temperature
      puts "Temperature is set to #{temperature}"
    else
      puts "You can't set onboard temperature on this vehicle"
    end
  end
end