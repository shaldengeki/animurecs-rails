# spec/factories/users.rb
require 'faker'

FactoryGirl.define do
  factory :show do |f|
    name = Faker::Name.first_name + Faker::Name.last_name
    description = Faker::Lorem.characters(500)
    length = Faker::Lorem.characters(150)
    link = Faker::Lorem.characters(100)
    f.name name
    f.description description
    f.length length
    f.link link
    f.upvotes 0 + Random.rand(100)
    f.downvotes 0 + Random.rand(100)
  end
end