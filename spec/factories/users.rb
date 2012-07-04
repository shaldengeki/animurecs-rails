# spec/factories/users.rb
require 'faker'

FactoryGirl.define do
  factory :user do |f|
    username = Faker::Name.first_name + Faker::Name.last_name
    password = Faker::Lorem.characters()
    gender = Faker::Lorem.characters(10)
    description = Faker::Lorem.characters(140)
    f.username username
    f.password password
    f.password_confirmation password
    f.userlevel 1 + Random.rand(5)
    f.age 1 + Random.rand(150)
    f.gender gender
    f.description description
  end
end