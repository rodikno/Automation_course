require '../Rail_Vehicle/train'
require '../Modules/wifi'

class HyundaiHRCS2 < Train

  include WiFi

  attr_reader :is_wifi_enabled

  def initialize
    super
    @is_wifi_enabled = false
  end

  def connect_wifi
    super
    @is_wifi_enabled = true
  end

  def disconnect_wifi
    super
    @is_wifi_enabled = false
  end

end

tr = HyundaiHRCS2.new
tr.connect_wifi
puts tr.is_wifi_enabled
