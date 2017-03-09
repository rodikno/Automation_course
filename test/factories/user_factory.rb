require 'factory_girl'
require 'faker'

FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    login { Faker::Internet.user_name("#{first_name} #{last_name}", %w(. _ -)) + rand(1000).to_s }
    password { Faker::Internet.password(4) }
    email { Faker::Internet.safe_email(login) }
    full_name { "#{first_name} #{last_name}" }
    id nil
  end
end