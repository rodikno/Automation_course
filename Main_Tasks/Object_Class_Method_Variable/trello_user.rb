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

  # @param [TrelloBoard] target_board
  # @param [String] list_name
  def create_list(list_name, target_board)
      if target_board
        target_board.create_list(list_name)
      else
        print "There's no board with id [" + target_board.id.to_s + "]\n"
      end
  end

  # @param [TrelloList] list
  # @param [TrelloBoard] board
  def delete_list(list, board)
    if is_board_in_users_boards?(board)
      if board.lists.include?(list)
        board.delete_list(list)
      else
        print "List with id [#{list.id}] is not found on board [#{board.name}]\n"
      end
    else
      print "User [#{self.username}] is not a member of board with id [#{board.id}]\n"
    end


  end

  # @param [TrelloList] list
  # @param [TrelloBoard] board
  # @param [Fixnum] new_position
  def move_list(list, board, new_position)
    if is_board_in_users_boards?(board)
      if board.lists.include?(list)
        board.move_list(list, new_position)
      else
        print "List with id [#{list.id}] is not found on board [#{board.name}]\n"
      end
    else
      print "User [#{self.username}] is not a member of board with id [#{board.id}]\n"
    end
  end

  # @param [TrelloBoard] board
  def get_all_lists(board)
    board.get_all_lists
  end

  # @param [String] card_name
  # @param [TrelloBoard] board
  # @param [TrelloList] list
  def create_card(card_name, board, list)
    if board
      if list
        list.create_card(card_name)
      else
        print "List with id [#{list.id}] is not found on board [#{board.name}]\n"
      end
    else
      print "User [#{self.username}] is not a member of board with id [#{board.id}]\n"
    end
  end

  # @param [TrelloCard] card
  # @param [TrelloBoard] board
  # @param [TrelloList] list
  def delete_card(card, board, list)
    if board
      if list
        list.delete_card(card)
      else
        print "List with id [#{list.id}] is not found on board [#{board.name}]\n"
      end
    else
      print "User [#{self.username}] is not a member of board with id [#{board.id}]\n"
    end
  end

  # @param [TrelloCard] card
  # @param [TrelloBoard] board
  # @param [TrelloList] target_list
  def move_card(card, board, target_list)
    if board
      board.move_card(card, target_list)
    else
      print "User [#{self.username}] is not a member of board with id [#{board.id}]\n"
    end
  end

  # @param [String] comment_text
  # @param [TrelloCard] card
  def add_comment(comment_text, card)
    if card
      author_name = self.username
      card.add_comment(comment_text, author_name)
    else
      print "Card with id [#{card.id}] doesn't exist\n"
    end
  end

  # @param [TrelloComment] comment
  # @param [TrelloBoard] board
  # @param [TrelloList] list
  # @param [TrelloCard] card
  def delete_comment(comment, board, list, card)
    if board
      if list
        if card
          card.delete_comment(comment)
        else
          print "Card with id [#{card.id}] doesn't exist in list [#{list.title}]\n"
        end
      else
        print "List with id [#{list.id}] is not found on board [#{board.name}]\n"
      end
    else
      print "User [#{self.username}] is not a member of board with id [#{board.id}]\n"
    end
  end

  private
  def is_board_in_users_boards?(board)
    if (@boards_joined.has_value?(board) or @boards_owned.has_value?(board))
      true
    else
      false
    end
  end

  def add_board_to_user_boards(board)
    board_id = board.id
    @boards_owned[board_id] = board
  end

  def add_board_to_joined_boards(board)
    board_id = board.id
    @boards_joined[board_id] = board
  end

  def remove_board_from_joined(board)
    board_id = board.id
    @boards_joined.delete(board_id)
  end
end