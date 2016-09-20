require_relative 'trello_comment'

class TrelloCard

  @@card_id_count = 0

  attr_accessor :title, :description, :parent_list
  attr_reader :id, :assignee

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

  def delete_comment(comment_id)
    comment = get_comment_by_id(comment_id)
    if comment
      @comments.delete(comment)
      print "Comment with id [#{comment_id}] removed successfully from card [#{self.title}]\n"
    else
      print "Comment with id [#{comment_id}] doesn't exist in card [#{self.title}]\n"
    end
  end

  def add_assignee(username)
    @assignee = username
  end

  private
  def get_comment_by_id(comment_id)
    required_comment = nil
    @comments.each {|comment| required_comment = comment if comment.id == comment_id}
    required_comment
  end
end