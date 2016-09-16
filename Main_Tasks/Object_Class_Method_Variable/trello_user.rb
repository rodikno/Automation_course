require 'faker'
require_relative 'trello_board'
require_relative 'trello_list'
require_relative 'trello_card'
require_relative 'trello_comment'

class TrelloUser

  attr_accessor :username, :first_name, :last_name, :email, :biography
  attr_reader :boards_owned, :boards_joined

  def initialize(username = "User" + rand(999))
    @username = username
    @first_name = Faker::Name.first_name
    @last_name = Faker::Name.last_name
    @email = Faker::Internet.email(@first_name)
    @biography = Faker::Hipster.sentence(5)
    @boards_owned = Hash.new
    @boards_joined = Hash.new
  end

  def create_board(board_name)
    board = TrelloBoard.new(board_name, self)
    add_board_to_user_boards(board)
    add_board_to_joined_boards(board)
    print "Board [" + board_name + "] is created\n"
    board
  end

  def join_board(board)
    add_board_to_joined_boards(board)
    board.add_member(self)
    print "User [" + self.username + "] joined the board [" + board.name + "]\n"
  end

  def leave_board(board)
    if board.is_user_a_creator?(self)
      raise StandardError, "You can't leave board which is your creation\n"
    else
      remove_board_from_joined(board)
      board.remove_member(self)
      print "User [" + self.username + "] has left board [" + board.name + "]\n"
    end
  end

  def create_list(list_name, target_board_id)
    begin
      board = @boards_joined.fetch(target_board_id)
      if board
        board.create_list(list_name)
      else
        raise StandardError
      end
    rescue KeyError
      print "Error! Board with ID [" + target_board_id.to_s + "] doesn't exist\n"
    rescue StandardError
      print "Unable to add a list to the board which you're not a member of\n"
    rescue Exception => e
      print e.message
    end
  end

  def get_all_created_boards
    ids_names_hash = Hash.new
    @boards_owned.each_pair do |id, board|
      ids_names_hash[id] = board.name
    end
    print "Boards, created by user [" + self.username + "]: " + ids_names_hash.to_s + "\n"
  end

  def get_all_joined_boards
    ids_names_hash = Hash.new
    @boards_joined.each_pair do |id, board|
      ids_names_hash[id] = board.name
    end
    print "Boards, where [" + self.username + "] is a member: " + ids_names_hash.to_s + "\n"
  end

  private
  def add_board_to_user_boards(board)
    board_id = board.board_id
    @boards_owned[board_id] = board
  end

  def add_board_to_joined_boards(board)
    board_id = board.board_id
    @boards_joined[board_id] = board
  end

  def remove_board_from_joined(board)
    board_id = board.board_id
    @boards_joined.delete(board_id)
  end

end