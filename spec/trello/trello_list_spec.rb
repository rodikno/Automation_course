require './spec/spec_helper'

describe TrelloList do

  user = TrelloUser.new
  board = user.create_board(Faker::Hacker.noun)

  context 'When I create a list on an existing board' do
    list = user.create_list(Faker::Hacker.verb, board)

    it 'list is created' do
      expect(list).to be_a_kind_of TrelloList
    end
    it 'list is added to the board' do
      expect(board.lists).to include list
    end
    it 'parent board is assigned to the list' do
      expect(list.parent_board).to eql board
    end

    context 'When I move the list within a board' do
      target_position = rand(10)
      before do
        user.move_list(list, target_position)
      end
      it 'position of the list is changed' do
        expect(list.position).to eql target_position
      end
    end

    context 'When I delete a list' do
      before do
        user.delete_list(list)
      end
      it 'list is removed from parent board' do
        expect(board.lists).not_to include list
      end
    end
  end

end