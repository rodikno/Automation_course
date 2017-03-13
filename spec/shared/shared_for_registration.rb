require './spec/spec_helper'

shared_examples 'Successfully registered user' do |user|
  include_context 'Register a new user', user
  it ': Then new user is registered' do
    expect(on(MyAccountPage)).to have_success_message
  end
end

shared_context 'Register a new user' do |user|
  before :all do
    log_out
    visit(RegistrationPage).register_user(user)
  end
end

shared_context 'Register users' do |*args|
  count = 0
  args.length.times do
    include_context 'Register a new user', args[count]
    count += 1
  end
end