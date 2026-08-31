require 'rails_helper'

RSpec.describe Exercise, type: :model do
  let(:subject) { create :exercise }

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
