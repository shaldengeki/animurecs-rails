# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :list_entry do
    list nil
    show nil
    score 1
    last_watched_at "2012-07-04 09:48:55"
    comments "MyString"
  end
end
