require 'date'

class TrelloComment

  @@comment_id_count = 0

  attr_accessor :comment_text
  attr_reader :author, :created_date

  def initialize(comment_text = "", author_name, parent_card)
    @@comment_id_count += 1
    @id = @@comment_id_count
    @comment_text = comment_text
    @parent_card = parent_card
    @author = author_name
    @created_date = Time.now.strftime("%d/%m/%Y %H:%M")
  end

end