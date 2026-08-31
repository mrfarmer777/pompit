FactoryBot.define do
  factory :exercise do
    name { Faker::Name.name }
  end
end