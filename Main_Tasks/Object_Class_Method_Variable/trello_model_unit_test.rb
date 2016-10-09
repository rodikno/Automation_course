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
    list = user.create_list(@listname, board)
    assert(list.kind_of?(TrelloList))
    assert_equal(@listname, list.title)
    assert(board.lists.include?(list))
  end

  def test_delete_list
    user = TrelloUser.new(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    user.delete_list(list, board)
    assert_false(board.lists.include?(list))
  end

  def test_move_list
    desired_position = 3
    user = TrelloUser.new(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    user.move_list(list, board, desired_position)
    assert_equal(list.position, desired_position)
  end

  def test_get_all_lists

  end

  def test_create_card
    card_name = "My Card"
    user = TrelloUser.new(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    card = user.create_card(card_name, board, list)
    assert(card.kind_of?(TrelloCard))
    assert_equal(card_name, card.title)
  end

  def test_delete_card
    card_name = "My Card"
    user = TrelloUser.new(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    card = user.create_card(card_name, board, list)
    user.delete_card(card, board, list)
    assert_false(list.cards.include?(card))
  end

  def test_move_card
    card_name = "My Card"
    other_list_name = "Other List"
    user = TrelloUser.new(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    other_list = user.create_list(other_list_name, board)
    card = user.create_card(card_name, board, list)
    user.move_card(card, board, other_list)
    assert_false(list.cards.include?(card))
    assert(other_list.cards.include?(card))
    assert_equal(other_list, card.parent_list)
  end

  def test_add_comment
    card_name = "My Card"
    comment_text = "This is the comment"
    user = TrelloUser.new(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    card = user.create_card(card_name, board, list)
    comment = user.add_comment(comment_text, board, list, card)
    assert(comment.kind_of?(TrelloComment))
    assert_equal(comment_text, comment.comment_text)
  end

  def test_delete_comment
    card_name = "My Card"
    comment_text = "This is the comment"
    user = TrelloUser.new(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    card = user.create_card(card_name, board, list)
    comment = user.add_comment(comment_text, board, list, card)
    user.delete_comment(comment, board, list, card)
    assert_false(card.comments.include?(comment))
  end

end