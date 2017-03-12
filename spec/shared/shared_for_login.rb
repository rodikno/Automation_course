require './spec/spec_helper'

shared_examples 'Successfully log in as' do |user|
  include_context 'Log in as', user
  it ': Then I am logged in' do
    expect(@current_page.top_menu.active_user_element.text).to eql user.login
  end
end

shared_context 'Log in as' do |user|
  before :all do
    log_out
    visit(LoginPage).log_in_as(user)
  end
end