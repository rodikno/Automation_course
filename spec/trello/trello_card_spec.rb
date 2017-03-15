require './spec/spec_helper'

describe TrelloCard, :trello do

  user = TrelloUser.new
  board = user.create_board(Faker::Hacker.noun)
  list = user.create_list(Faker::Hacker.verb, board)

  context 'When I create a card in existing list' do
    card_name = Faker::Hacker.adjective.capitalize
    card = user.create_card(card_name, list)
    it 'card is created' do
      expect(card).to be_a_kind_of TrelloCard
    end
    it 'card is added to parent list' do
      expect(list.cards).to include card
    end
    it 'parent list is added for the card' do
      expect(card.parent_list).to eql list
    end
    it 'card has correct name' do
      expect(card.name).to eql card_name
    end

    context 'When I move a card to another list on the same board' do
      target_list = user.create_list(list.title + '2', board)
      before (:all) { user.move_card(card, target_list) }
      it 'card is removed from source list' do
        expect(list.cards).not_to include card
      end
      it 'card is added to a new list' do
        expect(target_list.cards).to include card
      end
      it 'parent list of a card is changed to a new one' do
        expect(card.parent_list).to eql target_list
      end

      context 'When I delete a card' do
        before (:all) { user.delete_card(card) }
        it 'card is removed from parent list' do
          expect(target_list.cards).not_to include card
        end
      end
    end
  end
end