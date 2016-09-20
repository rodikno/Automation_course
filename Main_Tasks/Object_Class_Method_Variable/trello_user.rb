require 'faker'
require_relative 'trello_board'
require_relative 'trello_list'
require_relative 'trello_card'
require_relative 'trello_comment'

class TrelloUser

  attr_accessor :username, :first_name, :last_name, :email, :biography
  attr_reader :boards_owned, :boards_joined

  # @param [String] username
  def initialize(username = "User" + rand(999))
    @username = username
    @first_name = Faker::Name.first_name
    @last_name = Faker::Name.last_name
    @email = Faker::Internet.email(@first_name)
    @biography = Faker::Hipster.sentence(5)
    @boards_owned = Hash.new
    @boards_joined = Hash.new
  end

  # @param [String] board_name
  def create_board(board_name)
    board = TrelloBoard.new(board_name, self)
    add_board_to_user_boards(board)
    add_board_to_joined_boards(board)
    print "Board [" + board_name + "] is created\n"
    board
  end

  # @param [TrelloBoard] board
  def join_board(board)
    add_board_to_joined_boards(board)
    board.add_member(self)
    print "User [" + self.username + "] joined the board [" + board.name + "]\n"
  end

  # @param [TrelloBoard] board
  def leave_board(board)
    if board.is_user_a_creator?(self)
      raise StandardError, "You can't leave board which is your creation\n"
    else
      remove_board_from_joined(board)
      board.remove_member(self)
      print "User [" + self.username + "] has left board [" + board.name + "]\n"
    end
  end

  # @return Pretty prints all created boards
  def get_all_created_boards
    ids_names_hash = Hash.new
    @boards_owned.each_pair do |id, board|
      ids_names_hash[id] = board.name
    end
    print "Boards, created by user [" + self.username + "]: " + ids_names_hash.to_s + "\n"
  end

  # @return Pretty prints all joined boards
  def get_all_joined_boards
    ids_names_hash = Hash.new
    @boards_joined.each_pair do |id, board|
      ids_names_hash[id] = board.name
    end
    print "Boards, where [" + self.username + "] is a member: " + ids_names_hash.to_s + "\n"
  end

  # @param [Fixnum] target_board_id
  # @param [String] list_name
  def create_list(list_name, target_board_id)
      board = get_board_by_id(target_board_id)
      if board
        board.create_list(list_name)
      else
        print "There's no board with id [" + target_board_id.to_s + "]\n"
      end
  end

  # @param [Fixnum] list_id
  # @param [Fixnum] board_id
  def delete_list(list_id, board_id)
    if is_board_in_users_boards?(board_id)
      board = get_board_by_id(board_id)
      lists_ids = board.get_all_lists_ids
      if lists_ids.include?(list_id)
        board.delete_list(list_id)
      else
        print "List with id [#{list_id}] is not found on board [#{board.name}]\n"
      end
    else
      print "User [#{self.username}] is not a member of board with id [#{board_id}]\n"
    end


  end

  # @param [Fixnum] list_id
  # @param [Fixnum] board_id
  # @param [Fixnum] new_position
  def move_list(list_id, board_id, new_position)
    if is_board_in_users_boards?(board_id)
      board = get_board_by_id(board_id)
      lists_ids = board.get_all_lists_ids
      if lists_ids.include?(list_id)
        board.move_list(list_id, new_position)
      else
        print "List with id [#{list_id}] is not found on board [#{board.name}]\n"
      end
    else
      print "User [#{self.username}] is not a member of board with id [#{board_id}]\n"
    end
  end

  # @param [Fixnum] board_id
  def get_all_lists(board_id)
    board = get_board_by_id(board_id)
    board.get_all_lists
  end

  # @param [String] card_name
  # @param [Fixnum] board_id
  # @param [Fixnum] list_id
  def create_card(card_name, board_id, list_id)
    board = get_board_by_id(board_id)
    if board
      list = board.get_list_by_id(list_id)
      if list
        list.create_card(card_name)
      else
        print "List with id [#{list_id}] is not found on board [#{board.name}]\n"
      end
    else
      print "User [#{self.username}] is not a member of board with id [#{board_id}]\n"
    end
  end

  # @param [Fixnum] card_id
  # @param [Fixnum] board_id
  # @param [Fixnum] list_id
  def delete_card(card_id, board_id, list_id)
    board = get_board_by_id(board_id)
    if board
      list = board.get_list_by_id(list_id)
      if list
        list.delete_card(card_id)
      else
        print "List with id [#{list_id}] is not found on board [#{board.name}]\n"
      end
    else
      print "User [#{self.username}] is not a member of board with id [#{board_id}]\n"
    end
  end

  def move_card(card_id, board_id, source_list_id, target_list_id)
    board = get_board_by_id(board_id)
    if board
      board.move_card(card_id, source_list_id, target_list_id)
    else
      print "User [#{self.username}] is not a member of board with id [#{board_id}]\n"
    end
  end

  
  private
  def is_board_in_users_boards?(board_id)
    board = get_board_by_id(board_id)
    if (@boards_joined.has_value?(board) or @boards_owned.has_value?(board))
      true
    else
      false
    end
  end

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
  
  def get_board_by_id(board_id)
    begin
      board = @boards_joined.fetch(board_id)
    rescue KeyError
      return nil
    end
    board
  end

end