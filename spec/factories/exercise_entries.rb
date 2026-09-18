FactoryBot.define do
  factory :exercise_entry do
    workout_exercise { create :workout_exercise }
    workout_entry { create :workout_entry }
    set_number { 1 }
    weight { 20 }
    reps { 12 }
  end
end
