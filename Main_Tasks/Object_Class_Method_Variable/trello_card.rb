
class TrelloCard

  attr_accessor :title, :description

  def initialize(card_title)
    @title = card_title
    @description = String.new
    @assignee = String.new
    @comments = Array.new
  end

  def add_comment(comment)
    @comments << comment
  end

  def add_assignee(username)
    @assignee = username
  end

end