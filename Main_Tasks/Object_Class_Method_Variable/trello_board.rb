
class TrelloBoard

  attr_accessor :name, :background_color
  attr_reader :lists, :members

  def initialize(board_name, creator_name)
    @name = board_name
    @members = Array.new << creator_name
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

  def add_member(member_username)
    @members << member_username unless @members.include?(member_username)
  end

end