require_relative 'trello_user'
require_relative 'trello_board'
require_relative 'trello_list'
require_relative 'trello_card'
require_relative 'trello_comment'

#create a user
first_user = TrelloUser.new("rodikno")
second_user = TrelloUser.new("megapixel")

#create a board for this user
main_board = first_user.create_board("My First Board")
second_board = first_user.create_board("My Second board")

third_board = second_user.create_board("Second users board")
first_user.join_board(third_board)
#first_user.leave_board(third_board)

first_user.get_all_created_boards
first_user.get_all_joined_boards

first_user.create_list("TODO", 1)


print "OK"

#print first_user.boards_joined[1].to_s
#main_board.remove_member(first_user) #will raise an Error because can't remove creator from board
#first_user.create_list(list_name, board)
#create list on the board
# first_user.create_list("MyList", board_id)
# first_user

#add a card to specific list on a board
#card = TrelloCard.new("Rodion's nice card")
#card.description = "We need to finish this stuff"

#list.add_card(card)

#add a comment for a card
#comment = TrelloComment.new
#comment.text = "This is my first comment"

#card.add_comment(comment)

