require 'date'

class TrelloComment

  attr_accessor :text
  attr_reader :author, :created_date

  def initialize(text = "", user, parent_card)
    @text = text
    @parent_card = parent_card
    @author = user
    @created_date = Time.now.strftime("%d/%m/%Y %H:%M")
  end

end