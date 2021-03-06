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
    @cards = []
    @position = 0
  end

  def add_card(card)
    @cards << card
    print "Card [#{card.name}] is added to list [#{self.title}] successfully\n"
  end

  def create_card(card_name)
    card = TrelloCard.new(card_name, self)
    @cards << card
    card
  end

  def delete_card(card)
    if card
      @cards.delete(card)
      print "Card with id [#{card.id}] removed successfully from list [#{self.title}]\n"
    else
      print "Card with id [#{card.id}] doesn't exist in list [#{self.title}]\n"
    end
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