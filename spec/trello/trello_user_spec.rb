require './spec/spec_helper'

describe TrelloUser, :trello do
  context 'When I create a new user' do
    user = TrelloUser.new
    it "new user is created" do
      expect(user).to be_a_kind_of TrelloUser
    end
  end
end