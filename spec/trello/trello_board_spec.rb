require './spec/spec_helper'

describe TrelloBoard do

  user = TrelloUser.new

  context 'When I create a board' do
    let (:board_name) {"My Board"}
    let (:board) { user.create_board(board_name) }
    it 'new board is created' do
      expect(board).to be_a_kind_of TrelloBoard
    end
    it 'user is set as board creator' do
      expect(board.creator). to eql user
    end
    it 'board name is correct' do
      expect(board.name). to eql board_name
    end
  end

  context 'When I join a board created by another user' do
    new_user = TrelloUser.new
    new_board = new_user.create_board(Faker::Hacker.noun)
    before do
      user.join_board(new_board)
    end
    it 'I see board in my joined boards list' do
      expect(user.boards_joined).to have_value new_board
    end
    it 'I see myself in list of board members' do
      expect(new_board.members).to include user
    end

    context 'When I leave a board I was a member of' do
      before do
        user.leave_board(new_board)
      end
      it "Board is removed from list 'joined by me'" do
        expect(user.boards_joined).to_not have_value new_board
      end
      it "I'm removed from the list of board members" do
        expect(new_board.members).to_not include user
      end
    end
  end

end
