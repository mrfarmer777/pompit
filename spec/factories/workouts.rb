FactoryBot.define do
  factory :workout do
    name { Faker::Sport.ancient_olympics_sport }

    trait :with_exercises do
      transient do
        exercise_count { 3 }
      end

      after(:create) do |workout, evaluator|
        create_list(:workout_exercise, evaluator.exercise_count, workout:)
      end
    end
  end
end
