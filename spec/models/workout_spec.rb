require 'rails_helper'

RSpec.describe Workout, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:workout_exercises) }
    it { should have_many(:exercises).through(:workout_exercises) }
    it { should have_many(:entries).class_name('WorkoutEntry') }
  end

  it { should accept_nested_attributes_for(:workout_exercises) }
end
