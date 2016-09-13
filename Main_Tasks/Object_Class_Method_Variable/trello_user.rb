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
    @boards = Array.new
  end

  def create_board(board_name)
    board = TrelloBoard.new(board_name, self)
    @boards << board
    board
  end

  def join_board(board)
    @boards << board
    board.add_member(self)
  end

  def leave_board(board)
    @boards.delete(board)
    board.remove_member(self)
  end

  def create_list(list_name, board_where)
    board_index = @boards.index(board_where)
    if board_index
      required_board = @boards.fetch(board_index)
      required_board.create_list(list_name)
    end
  end

end