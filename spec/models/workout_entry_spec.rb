require 'rails_helper'

RSpec.describe WorkoutEntry, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:date) }
  end

  describe 'associations' do
    it { should belong_to(:workout) }
  end
end
