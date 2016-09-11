require_relative 'user'
require_relative 'trello_board'
require_relative 'trello_list'
require_relative 'trello_card'
require_relative 'trello_comment'

#create a user
username = 'megapixel'
first_user = User.new(username)

#create a board for this user
main_board = TrelloBoard.new(first_user)
first_user.add_board(main_board)

#add a list to the board
list = TrelloList.new('Rodions List')
main_board.add_list(list)

#add a card to specific list on a board
card = TrelloCard.new
card.title = "Rodion's first card"
card.description = "We need to finish this stuff"

list.add_card(card)

#add a comment for a card
comment = TrelloComment.new
comment.text = "This is my first comment"

card.add_comment(comment)
