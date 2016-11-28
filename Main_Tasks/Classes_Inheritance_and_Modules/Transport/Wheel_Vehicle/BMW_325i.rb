require '../Wheel_Vehicle/car'
require '../../Actions/actions'
require '../Modules/security_alarm'

class BMW325i < Car

  include SecurityAlarm

  def initialize
    super
    @color = :black
  end

end

bmw = BMW325i.new

bmw.drive(150)
Actions.touch(bmw)
