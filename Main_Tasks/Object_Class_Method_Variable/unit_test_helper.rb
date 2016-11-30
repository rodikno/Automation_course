require_relative 'trello_user'
require_relative 'trello_board'
require_relative 'trello_card'
require_relative 'trello_comment'
require 'faker'

module TrelloUnitTestHelper

  # @param [String] username
  def create_user(username)
    TrelloUser.new(username)
  end

  # @param [String] board_name
  # @param [TrelloUser] user_creator
  def create_board(board_name, user_creator)
    TrelloBoard.new(board_name, user_creator)
  end

end