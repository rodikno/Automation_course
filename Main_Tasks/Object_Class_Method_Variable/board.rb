
class Board
  def initialize(board_name)
    @name = Faker::Hacker.noun
    @lists = Array.new
    @background_color = "Black"
  end

  attr_accessor :name, :lists, :background_color

  def add_lists(lists_array)
    lists_array.each do |list|
      lists << list
    end
  end

end