FactoryBot.define do
  factory :genre do
    sequence(:title) { |n| "#{Faker::Book.genre}#{n}" }
  end
end