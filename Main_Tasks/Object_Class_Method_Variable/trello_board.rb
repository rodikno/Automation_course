require_relative 'trello_list'

class TrelloBoard

  @@board_id_count = 0 #I know that's a bad style but have no idea how to get unique id without external DB

  attr_accessor :name, :background_color
  attr_reader :lists, :members, :board_id

  def initialize(board_name, user_creator)
    @board_id = @@board_id_count + 1
    @name = board_name
    @creator = user_creator
    @members = Array.new << user_creator
    @lists = Array.new
    @background_color = Faker::Color.color_name
  end

  def add_list(list)
    lists << list
  end

  def add_member(member)
    @members << member unless @members.include?(member)
  end

  def remove_member(user)
    if is_user_a_member?(user)
      begin
        unless is_user_a_creator?(user)
          @members.delete(user)
        end
      raise StandardError, "You can't remove creator from his own board" if is_user_a_creator?(user)
      end
    else
      print "You can't remove this user because he's not a member of this board\n"
    end
  end

  def is_user_a_creator?(user)
    user.equal?(@creator) ? true : false
  end

  def is_user_a_member?(user)
    @members.include?(user) ? true : false
  end

end