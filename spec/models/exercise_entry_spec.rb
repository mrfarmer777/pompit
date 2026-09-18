require 'rails_helper'

RSpec.describe ExerciseEntry, type: :model do
  describe 'validations' do
    let(:subject) { create(:exercise_entry) }

    it { should validate_presence_of(:set_number) }
    it { should validate_presence_of(:reps) }
    it { should validate_numericality_of(:reps).is_greater_than(0).only_integer }
    it { should validate_numericality_of(:set_number).is_greater_than(0).only_integer }
    it { should validate_numericality_of(:weight).is_greater_than(0).allow_nil }

    it 'validates that the set number is less than or equal to the number of sets in the workout_exercise' do
      workout_exercise = create(:workout_exercise, set_count: 1)
      workout_entry = create(:workout_entry, workout_id: workout_exercise.workout.id)
      exercise_entry = build(:exercise_entry, workout_entry_id: workout_entry.id,
                             workout_exercise_id: workout_exercise.id, set_number: 2)

      expect(exercise_entry).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:workout_entry).required }
    it { should belong_to(:workout_exercise).required }
  end
end
