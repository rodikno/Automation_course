require 'faker'
require 'rspec'
require 'test/unit'
require_relative 'trello_user'
require_relative 'trello_board'
require_relative 'trello_list'
require_relative 'trello_card'
require_relative 'trello_comment'
require_relative 'unit_test_helper'

class TestTrelloModel < Test::Unit::TestCase

  include RSpec::Matchers
  include TrelloUnitTestHelper

  def setup
    @username = Faker::Name.first_name.to_s
    @boardname = Faker::Hacker.noun
    @listname = Faker::Hacker.noun.capitalize
    @cardname = Faker::Hacker.noun
    @comment_text = Faker::Hipster.sentence
  end

  def test_create_user
    first_user = create_user(@username)

    expect(first_user).to be_a_kind_of TrelloUser
    expect(first_user.username).to eql @username
  end

  def test_create_board
    some_user = create_user(@username)
    board = some_user.create_board(@boardname)

    expect(board).to be_a_kind_of TrelloBoard
    expect(board.creator).to eql some_user
    expect(board.name).to eql @boardname
  end

  def test_join_board
    board_creator = create_user(@username + "Creator")
    some_user = create_user(@username)
    board = board_creator.create_board(@boardname)
    some_user.join_board(board)

    expect(some_user.boards_joined).to have_value board
    #TODO Ask Dima why this doesn't work (Array board.members doesn't respond to has_value? but responds to include?) WTF?
    #expect(board.members).to have_value some_user
    expect(board.members).to include some_user
  end

  def test_leave_board
    first_user, second_user = create_user(@username), create_user(@username + "2")
    board = first_user.create_board(@boardname)
    second_user.join_board(board)
    second_user.leave_board(board)

    assert_false(second_user.boards_joined.has_value?(board))
    assert_false(board.members.include?(second_user))
  end

  def test_create_list
    user = create_user(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)

    assert(list.kind_of?(TrelloList))
    assert(board.lists.include?(list))
    assert_equal(board, list.parent_board)
    assert_equal(@listname, list.title)
  end

  def test_delete_list
    user = create_user(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    user.delete_list(list)

    assert_false(board.lists.include?(list))
  end

  def test_move_list
    target_position = 3
    user = create_user(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    user.move_list(list, target_position)

    assert_equal(list.position, target_position)
  end

  def test_get_all_lists

  end

  def test_create_card
    user = create_user(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    card = user.create_card(@cardname, list)

    assert(card.kind_of?(TrelloCard))
    assert(list.cards.include?(card))
    assert_equal(list, card.parent_list)
    assert_equal(@cardname, card.name)
  end

  def test_delete_card
    user = create_user(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    card = user.create_card(@cardname, list)
    user.delete_card(card)

    assert_false(list.cards.include?(card))
  end

  def test_move_card
    other_list_name = @listname + "2"
    user = create_user(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    target_list = user.create_list(other_list_name, board)
    card = user.create_card(@cardname, list)
    user.move_card(card, target_list)

    assert_false(list.cards.include?(card))
    assert(target_list.cards.include?(card))
    assert_equal(target_list, card.parent_list)
  end

  def test_add_comment
    user = create_user(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    card = user.create_card(@cardname, list)
    comment = user.add_comment(@comment_text, card)

    assert(comment.kind_of?(TrelloComment))
    assert_equal(card, comment.parent_card)
    assert_equal(@comment_text, comment.comment_text)
  end

  def test_delete_comment
    user = create_user(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    card = user.create_card(@cardname, list)
    comment = user.add_comment(@comment_text, card)
    user.delete_comment(comment)

    assert_false(card.comments.include?(comment))
  end

end