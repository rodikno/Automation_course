
class TrelloList

  attr_reader :cards, :sequence_num, :parent_board
  attr_accessor :list_title

  def initialize(list_title, parent_board)
    @list_title = list_title
    @parent_board = parent_board
    @cards = Array.new
    @sequence_num = 0
  end

  def add_card(card)
    @cards << card
  end

  def move_list(new_sequence_num)
    if new_sequence_num >= 0
      @sequence_num = new_sequence_num
    else
      raise StandardError "Sequence number can't be less than 0"
    end
  end

end