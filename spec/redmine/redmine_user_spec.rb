require './spec/spec_helper'


describe '[User]', :redmine, :user do

  describe '[Registration]' do
    context 'When I register a user' do
      user = RedmineUser.new
      include_examples 'Successfully registered user', user
    end
  end

  describe '[Log out]' do
    context 'When I have an existing user' do
      user = RedmineUser.new
      include_context 'Register a new user', user
      context 'And I log out' do
        before { on(TopMenuSection).log_out }
        it ': Then I am logged out' do
          expect(on(TopMenuSection).log_in_element).to be_visible
        end
      end
    end
  end

  describe '[Log in]' do
    context 'When I have an existing user' do
      user = RedmineUser.new
      include_context 'Register a new user', user
      context 'And I log in' do
        include_examples 'Successfully log in as', user
      end
    end
  end

  describe '[Change password]' do
    context 'When I have an existing user' do
      user = RedmineUser.new
      include_context 'Register a new user', user
      context 'And I change password' do
        new_password = Faker::Internet.password(4)
        before :all do
          visit(ChangePasswordPage).change_password(user, new_password)
        end
        it ': Then success message is shown' do
          expect(on(MyAccountPage)).to have_success_message
        end
        context 'When I log in using a new password' do
          include_examples 'Successfully log in as', user
        end
      end
    end
  end

end