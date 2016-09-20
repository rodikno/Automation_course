require 'test/unit'
require_relative 'trello_user'
require_relative 'trello_board'
require_relative 'trello_list'
require_relative 'trello_card'
require_relative 'trello_comment'

class TestTrelloModel < Test::Unit::TestCase

  def setup

  end

  def test_create_user
    first_user = TrelloUser.new("myuser")
    assert(first_user.kind_of?(TrelloUser))
  end
end