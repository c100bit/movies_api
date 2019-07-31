FactoryBot.define do
  factory :genre do
    title { Faker::Book.genre  }
  end
end