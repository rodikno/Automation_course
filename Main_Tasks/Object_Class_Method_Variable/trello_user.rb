require 'faker'
require_relative 'trello_board'
require_relative 'trello_list'
require_relative 'trello_card'
require_relative 'trello_comment'

class TrelloUser

  attr_accessor :username, :first_name, :last_name, :email, :biography

  def initialize(username = "User" + rand(999))
    @username = username
    @first_name = Faker::Name.first_name
    @last_name = Faker::Name.last_name
    @email = Faker::Internet.email(@first_name)
    @biography = Faker::Hipster.sentence(5)
    @boards_owned = Hash.new
  end
  
  def add_board_to_user_boards(board)
    board_id_symbol = board.board_id.to_s.to_sym
    @boards_owned[board_id_symbol] = board
  end

  def create_board(board_name)
    board = TrelloBoard.new(board_name, self)
    add_board_to_user_boards(board)
    board
  end

  def join_board(board)
    add_board_to_user_boards(board)
    board.add_member(self)
  end

  def get_all_board_ids

  end

  # Need to rework this to support woking with hash @boards_owned
  # def leave_board(board_id)
  #   @boards_owned.delete(board)
  #   board.remove_member(self)
  # end

  def create_list(list_name, board_id_where)
    board_index = @boards.index(board_where)
    if board_index
      required_board = @boards.fetch(board_index)
      required_board.create_list(list_name)
    end
  end

end