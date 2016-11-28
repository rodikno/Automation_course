module SecurityAlarm

  def activate
    puts 'Security alarm is activated'
  end

  def inactivate
    puts 'Security alarm is inactivated'
  end

  def when_touched
    puts "Alarm is triggered. WEEEEO, WEEEO, WEEEO, BEEP, BEEEP, BEEP!!!"
    touched = true
  end

end