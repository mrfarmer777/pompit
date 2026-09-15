FactoryBot.define do
  factory :workout_entry do
    date { Date.today }
    workout { FactoryBot.create(:workout) }
  end
end
