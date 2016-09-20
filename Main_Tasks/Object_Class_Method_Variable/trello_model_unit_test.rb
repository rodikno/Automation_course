require 'test/unit'
require 'faker'
require_relative 'trello_user'
require_relative 'trello_board'
require_relative 'trello_list'
require_relative 'trello_card'
require_relative 'trello_comment'

class TestTrelloModel < Test::Unit::TestCase

  def setup
    @username = Faker::Name.first_name
  end

  def test_create_user
    first_user = TrelloUser.new(@username)
    assert(first_user.kind_of?(TrelloUser))
    assert_equal(@username, first_user.username)
  end

  def test_create_board

  end

  def test_join_board

  end

  def test_leave_board

  end

  def test_get_all_created_boards

  end

  def test_get_all_joined_boards

  end

  def test_create_list

  end

  def test_delete_list

  end

  def test_move_list

  end

  def test_get_all_lists

  def test_create_card

  end

  def test_delete_card

  end

  def test_move_card

  end

  def test_add_comment

  end

  def test_delete_comment

  end

end