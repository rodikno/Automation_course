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
first_user.create_list("IN PROGRESS", 1)
first_user.create_list("DONE", 1)
first_user.get_all_lists(1)
first_user.delete_list(56, 1)
first_user.get_all_lists(1)
first_user.create_card("My first card", 1, 1)
first_user.move_card(1, 1, 1, 2)
first_user.add_comment("My First Comment", 1, 2, 1)
first_user.delete_comment(1, 1, 2, 1)

print "OK"