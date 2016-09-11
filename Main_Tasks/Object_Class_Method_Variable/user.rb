require 'faker'
class User

  def initialize(username = "User" + rand(999))
    @username = username
    @first_name = Faker::Name.first_name
    @last_name = Faker::Name.last_name
    @email = Faker::Internet.email(@first_name)
  end

  attr_accessor :username, :first_name, :last_name, :email

  def add_board(board)
    board.add_user(username)
  end
end