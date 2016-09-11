require 'date'

class TrelloComment

  attr_accessor :text
  attr_reader :created_date

  def initialize
    @text = String.new
    @author = String.new
    @created_date = Time.now.strftime("%d/%m/%Y %H:%M")
  end

end