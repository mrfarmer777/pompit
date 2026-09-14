FactoryBot.define do
  factory :workout_exercise do
    workout { create :workout }
    exercise { create :exercise }
    set_count { 3 }
  end
end
