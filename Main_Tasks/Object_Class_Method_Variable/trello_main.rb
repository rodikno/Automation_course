#create a user
first_user = User.new(username)

#create a board for this user
main_board = Board.new(first_user)


#add 3 lists to the board
lists = List.generate(list_name1, list_name2, list_name3)
main_board.add_lists(lists)

#add a card to specific list on a board
card = Card.new(title)
main_board.add_card(card, list_name)

#add a comment for a card
comment = Comment.new
main_board.add_comment(comment, list_name, card_name)
main_board.lists(:todo).cards(:card1).add_comment(comment_text)