require 'test/unit'
require 'faker'
require_relative 'trello_user'
require_relative 'trello_board'
require_relative 'trello_list'
require_relative 'trello_card'
require_relative 'trello_comment'
require_relative 'unit_test_helper'

class TestTrelloModel < Test::Unit::TestCase

  include TrelloUnitTestHelper

  def setup
    @username = Faker::Name.first_name.to_s
    @boardname = Faker::Hacker.noun
    @listname = Faker::Hacker.noun.capitalize
  end

  def test_create_user
    first_user = TrelloUser.new(@username)
    assert(first_user.kind_of?(TrelloUser))
    assert_equal(@username, first_user.username)
  end

  def test_create_board
    some_user = TrelloUser.new(@username)
    board = some_user.create_board(@boardname)
    assert(board.kind_of?(TrelloBoard))
    assert_equal(@boardname, board.name)
  end

  def test_join_board
    board_creator = TrelloUser.new("Creator")
    some_user = TrelloUser.new(@username)
    some_board = TrelloBoard.new(board_creator, @boardname)
    some_user.join_board(some_board)
    assert(some_user.boards_joined.has_value?(some_board))
  end

  def test_leave_board
    first_user, second_user = TrelloUser.new(@username), TrelloUser.new(@username + "2")
    board = TrelloBoard.new(@boardname, first_user)
    second_user.join_board(board)
    second_user.leave_board(board)
    assert_false(board.members.include?(second_user))
  end

  def test_create_list
    user = TrelloUser.new(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board.id)
    assert(list.kind_of?(TrelloList))
    assert_equal(@listname, list.title)
    assert(board.lists.include?(list))
  end

  def test_delete_list
    user = TrelloUser.new(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board.id)
    user.delete_list(list.id, board.id)
    assert_false(board.lists.include?(list))
  end
  #
  # def test_move_list
  #
  # end
  #
  # def test_get_all_lists
  #
  # def test_create_card
  #
  # end
  #
  # def test_delete_card
  #
  # end
  #
  # def test_move_card
  #
  # end
  #
  # def test_add_comment
  #
  # end
  #
  # def test_delete_comment
  #
  # end

end