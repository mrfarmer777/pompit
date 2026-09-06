FactoryBot.define do
  factory :workout do
    name { Faker::Sport.ancient_olympics_sport }
  end
end
