require 'factory_girl'
require 'faker'

require './Main_Tasks/Object_Class_Method_Variable/trello_user'
require './Main_Tasks/Object_Class_Method_Variable/trello_board'


FactoryGirl.define do
  factory :user, class: TrelloUser do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { Faker::Internet.user_name("#{first_name} #{last_name}", %w(. _ -)) + rand(1000).to_s }
    email { Faker::Internet.safe_email(username) }
    biography { Faker::Hipster.sentence(5) }
  end
end