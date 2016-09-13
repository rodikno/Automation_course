
class TrelloBoard

  attr_accessor :name, :background_color
  attr_reader :lists, :members

  def initialize(board_name, user_creator)
    @name = board_name
    @members = Array.new << user_creator
    @lists = Array.new
    @background_color = "Black"
  end

  def add_list(list)
    lists << list
  end

  def add_lists(lists_array)
    lists_array.each do |list|
      lists << list
    end
  end

  def add_member(member)
    @members << member unless @members.include?(member)
  end

end