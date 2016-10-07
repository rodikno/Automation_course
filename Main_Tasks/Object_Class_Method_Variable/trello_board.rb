require_relative 'trello_list'

class TrelloBoard

  @@board_id_count = 0 #I know that's a bad style but have no idea how to get unique id without external DB

  attr_accessor :name, :background_color
  attr_reader :lists, :members, :id

  def initialize(board_name, user_creator)
    @@board_id_count += 1
    @id = @@board_id_count
    @name = board_name
    @creator = user_creator
    @members = [] << user_creator
    @lists = []
    @background_color = Faker::Color.color_name
  end

  def create_list(list_name)
    list = TrelloList.new(list_name, self)
    @lists << list
    print "List [#{list_name}] is created on board [#{self.name}]\n"
    list
  end

  def delete_list(list_id)
    @lists.delete_if {|list| list.id == list_id}
  end

  def move_list(list_id, new_position)
    @lists.each {|list| list.move_list(new_position) if list.id == list_id}
  end

  def get_list_by_id(list_id, &block)
    list = nil
    @lists.each {|li| list = li if li.id == list_id}
    if list
      list
    else
      yield
    end
  end

  def get_all_lists
    print "Board [#{self.name}] contains lists:\n"
    @lists.each do |list|
      print "List [" + list.title + "] with id [" + list.id.to_s + "]\n"
    end
  end

  # @return [Array]
  def get_all_lists_ids
    list_ids = []
    @lists.each do |list|
      list_ids << list.id
    end
    list_ids
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

  def move_card(card_id, source_list_id, target_list_id)
    source_list = get_list_by_id(source_list_id) {print "List with id [#{source_list_id}] doesn't exist"}
    target_list = get_list_by_id(target_list_id) {print "List with id [#{target_list_id}] doesn't exist"}
    if source_list and target_list
      card = source_list.get_card_by_id(card_id)
      card.parent_list = target_list
      target_list.add_card(card)
      source_list.delete_card(card_id)
      print "Card [#{card_id}] moved from [#{source_list.title}] to [#{target_list.title}]\n"
    end
  end

  def is_user_a_creator?(user)
    user.equal?(@creator) ? true : false
  end

  def is_user_a_member?(user)
    @members.include?(user) ? true : false
  end

end