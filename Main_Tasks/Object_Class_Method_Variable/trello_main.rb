#create a user
first_user = User.new(username)

#create a board for this user
main_board = Board.new(first_user)

first_user.add_board(main_board)


#add 3 lists to the board
lists = List.generate(list_name1, list_name2, list_name3)
main_board.add_lists(lists)

#add a card to specific list on a board
card = Card.new(title)
lists[:todo].add_card(card)

#add a comment for a card
comment = Comment.new
card.add_comment(comment)
