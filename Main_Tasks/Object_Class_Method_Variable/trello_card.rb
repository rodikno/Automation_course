require_relative 'trello_comment'

class TrelloCard

  @@card_id_count = 0

  attr_accessor :name, :description, :parent_list
  attr_reader :id, :assignee, :comments, :parent_board

  def initialize(card_title, parent_list)
    @@card_id_count += 1
    @id = @@card_id_count
    @name = card_title
    @parent_board = parent_list.parent_board
    @parent_list = parent_list
    @description = String.new
    @assignee = String.new
    @comments = []
    print "Card [#{card_title}] is created in list [#{parent_list.title}]\n"
  end

  def add_comment(comment_text, author_name)
    comment = TrelloComment.new(comment_text, author_name, self)
    @comments << comment
    print "Comment with text [#{comment_text}] is added to card [#{self.name}(id=[#{self.id}])]\n"
    comment
  end

  def delete_comment(comment)
    if comment
      @comments.delete(comment)
      print "Comment with id [#{comment.id}] removed successfully from card [#{self.name}]\n"
    else
      print "Comment with id [#{comment.id}] doesn't exist in card [#{self.name}]\n"
    end
  end

  def add_assignee(username)
    @assignee = username
  end
end