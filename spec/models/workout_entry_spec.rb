require 'rails_helper'

RSpec.describe WorkoutEntry, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:date) }
  end

  describe 'associations' do
    it { should belong_to(:workout) }
    it { should have_many(:exercise_entries).dependent(:destroy) }
    it { should have_many(:workout_exercises).through(:exercise_entries) }
    it { should have_many(:exercises).through(:workout_exercises) }
  end
end
