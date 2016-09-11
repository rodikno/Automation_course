require 'faker'
require_relative 'trello_board'

class User

  attr_accessor :username, :first_name, :last_name, :email

  def initialize(username = "User" + rand(999))
    @username = username
    @first_name = Faker::Name.first_name
    @last_name = Faker::Name.last_name
    @email = Faker::Internet.email(@first_name)
    @boards = Array.new
  end

  def add_board(board)
    @boards << board
    print @boards.flatten.to_s
  end

  def create_board(board_name)
    board = TrelloBoard.new(board_name)
    boards << board  
  end
    
end