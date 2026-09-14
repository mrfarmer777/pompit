require 'rails_helper'

RSpec.describe WorkoutExercise, type: :model do
  let(:subject) { create :workout_exercise }

  describe 'validations' do
    it { should validate_numericality_of(:set_count).is_greater_than(0).only_integer }
  end

  describe 'associations' do
    it { should belong_to(:workout).class_name('Workout') }
    it { should belong_to(:exercise).class_name('Exercise') }
  end
end
