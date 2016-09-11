
class TrelloList

  attr_reader :cards, :sequence_num
  attr_accessor :list_title, :board_name

  def initialize(list_title = "List")
    @list_title = list_title
    @board_name = "Default Board"
    @cards = Array.new
    @sequence_num = 0
  end

  def add_card(card)
    @cards << card
  end

  def sequence_num(number)
    @sequence_num = number
  end

  def move_list(new_sequence_num)
    @sequence_num = new_sequence_num
  end

end