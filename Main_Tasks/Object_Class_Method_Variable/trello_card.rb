require_relative 'trello_comment'

class TrelloCard

  @@card_id_count = 0

  attr_accessor :title, :description, :parent_list
  attr_reader :id

  def initialize(card_title, parent_list)
    @@card_id_count += 1
    @id = @@card_id_count
    @title = card_title
    @parent_list = parent_list
    @description = String.new
    @assignee = String.new
    @comments = Array.new
    print "Card [#{card_title}] is created in list [#{parent_list.title}]\n"
  end

  def add_comment(comment_text, author_name)
    comment = TrelloComment.new(comment_text, author_name, self)
    @comments << comment
    print "Comment with text [#{comment_text}] is added to card [#{self.title}(id=[#{self.id}])]\n"
  end

  def add_assignee(username)
    @assignee = username
  end

end