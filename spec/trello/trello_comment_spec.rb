require './spec/spec_helper'

describe TrelloComment, :trello do

  user = TrelloUser.new
  board = user.create_board(Faker::Hacker.noun.capitalize)
  list = user.create_list(Faker::Hacker.adjective, board)
  card = user.create_card(Faker::Hacker.verb, list)

  context 'When I add comment to the existing card' do
    text = Faker::Hipster.sentence(5)
    comment = user.add_comment(text, card)

    it 'comment is created' do
      expect(comment).to be_a_kind_of TrelloComment
    end
    it 'comment has correct parent card' do
      expect(comment.parent_card).to eql card
    end
    it 'comment has correct text' do
      expect(comment.comment_text).to eql text
    end

    context 'When I delete existing comment' do
      before (:all) { user.delete_comment(comment) }
      it 'comment is removed from parent card' do
        expect(card.comments).to_not include comment
      end
    end
  end
end