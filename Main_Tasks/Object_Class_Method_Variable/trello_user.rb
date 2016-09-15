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

  def create_board(board_name)
    board = TrelloBoard.new(board_name, self)
    add_board_to_user_boards(board)
    print "Board [" + board_name + "] is created\n"
    board
  end

  def join_board(board)
    add_board_to_user_boards(board)
    board.add_member(self)
    print "User [" + self.username + "] joined the board [" + board.name + "]\n"
  end
  
  def leave_board(board)
    if board.is_user_a_creator?(self)
      raise StandardError, "You can't leave board which is your creation\n"
    else
      remove_board_from_user_boards(board)
      board.remove_member(self)
      print "User [" + self.username + "] has left board [" + board.name + "]\n"
    end
  end

  def create_list(list_name, board_id_where)
    board_index = @boards.index(board_where)
    if board_index
      required_board = @boards.fetch(board_index)
      required_board.create_list(list_name)
    end
  end

  def get_all_board_ids_and_names
    ids_names_hash = Hash.new
    @boards_owned.each_pair do |id, board|
      ids_names_hash[id] = board.name
    end
    ids_names_hash
  end

  private
  def add_board_to_user_boards(board)
    board_id = board.board_id
    @boards_owned[board_id] = board
  end

  def remove_board_from_user_boards(board)
    board_id = board.board_id
    @boards_owned.delete(board_id)
  end

end