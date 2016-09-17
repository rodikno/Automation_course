require_relative 'trello_card'

class TrelloList

  @@list_id_count = 0

  attr_reader :cards, :position, :parent_board, :id
  attr_accessor :title

  def initialize(list_title, parent_board)
    @@list_id_count += 1
    @id = @@list_id_count
    @title = list_title
    @parent_board = parent_board
    @cards = Array.new
    @position = 0
  end

  def create_card(card_name)
    card = TrelloCard.new(card_name, self)
    @cards << card
  end

  def move_list(new_position)
    if new_position >= 0
      @position = new_position
      print "List [#{self.id}] is moved to position [#{new_position}]\n"
    else
      print "Position number couldn't be set to value less than 0\n"
    end
  end

end