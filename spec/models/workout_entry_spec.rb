require 'rails_helper'

RSpec.describe WorkoutEntry, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:date) }
  end

  describe 'associations' do
    it { should belong_to(:workout) }
    it { should have_many(:exercise_entries).dependent(:destroy) }
    it { should have_many(:workout_exercises).through(:exercise_entries) }
    it { should accept_nested_attributes_for(:exercise_entries).allow_destroy(true) }
    it { should have_many(:exercises).through(:workout_exercises) }
  end
end
