require 'faker'
require 'rspec'
require 'test/unit'
require_relative 'trello_board'
require_relative 'trello_card'
require_relative 'trello_comment'
require_relative 'trello_list'
require_relative 'trello_user'
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
    expect(board.members).to include some_user
  end

  def test_leave_board
    first_user, second_user = create_user(@username), create_user(@username + "2")
    board = first_user.create_board(@boardname)
    second_user.join_board(board)
    second_user.leave_board(board)

    expect(second_user.boards_joined).to_not have_value board
    expect(board.members).to_not include second_user
  end

  def test_create_list
    user = create_user(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)

    expect(list).to be_a_kind_of TrelloList
    expect(board.lists).to include list
    expect(list.parent_board).to eql board
    expect(list.title).to eql @listname
  end

  def test_delete_list
    user = create_user(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    user.delete_list(list)

    expect(board.lists).not_to include list
  end

  def test_move_list
    target_position = 3
    user = create_user(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    user.move_list(list, target_position)

    expect(list.position).to eql target_position
  end

  def test_create_card
    user = create_user(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    card = user.create_card(@cardname, list)

    expect(card).to be_a_kind_of TrelloCard
    expect(list.cards).to include card
    expect(card.parent_list).to eql list
    expect(card.name).to eql @cardname
  end

  def test_delete_card
    user = create_user(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    card = user.create_card(@cardname, list)
    user.delete_card(card)

    expect(list.cards).not_to include card
  end

  def test_move_card
    other_list_name = @listname + "2"
    user = create_user(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    target_list = user.create_list(other_list_name, board)
    card = user.create_card(@cardname, list)
    user.move_card(card, target_list)

    expect(list.cards).not_to include card
    expect(target_list.cards).to include card
    expect(card.parent_list).to eql target_list
  end

  def test_add_comment
    user = create_user(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    card = user.create_card(@cardname, list)
    comment = user.add_comment(@comment_text, card)

    expect(comment).to be_a_kind_of TrelloComment
    expect(comment.parent_card).to eql card
    expect(comment.comment_text).to eql @comment_text
  end

  def test_delete_comment
    user = create_user(@username)
    board = user.create_board(@boardname)
    list = user.create_list(@listname, board)
    card = user.create_card(@cardname, list)
    comment = user.add_comment(@comment_text, card)
    user.delete_comment(comment)

    expect(card.comments).to_not include comment
  end

end