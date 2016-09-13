require_relative 'trello_user'
require_relative 'trello_board'
require_relative 'trello_list'
require_relative 'trello_card'
require_relative 'trello_comment'

#create a user
username = 'megapixel'
first_user = TrelloUser.new(username)

#create a board for this user
main_board = TrelloBoard.new("Main Board", first_user)
first_user.join_board(main_board)

#add a list to the board
list = TrelloList.new("Rodion's super List")
main_board.add_list(list)

#add a card to specific list on a board
card = TrelloCard.new("Rodion's nice card")
card.description = "We need to finish this stuff"

list.add_card(card)

#add a comment for a card
comment = TrelloComment.new
comment.text = "This is my first comment"

card.add_comment(comment)

print "OK"

