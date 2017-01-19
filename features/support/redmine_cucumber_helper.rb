require 'C:\_projects\automation_course\Main_Solution\our_module.rb'

module RedmineCucumberHelper

  include OurModule

  def reset_hash(hash)
    hash.each_value{|value| value = nil}
  end

end