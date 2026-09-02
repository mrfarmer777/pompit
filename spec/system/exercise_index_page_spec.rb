require 'rails_helper'

RSpec.describe 'Exercise Pages', type: :system do

  context 'index' do
    let(:page_path) { exercises_path }
    let!(:pull_up) { create :exercise, name: 'Pull Up' }
    let!(:push_up) { create :exercise, name: 'Push Up' }

    it 'displays a list of links to exercise show pages' do
      visit page_path

      expect(page).to have_link('Pull Up', href: exercise_path(pull_up))
      expect(page).to have_link('Push Up', href: exercise_path(push_up))
    end

    it 'includes a link to add a new exercise' do
      visit page_path

      expect(page).to have_link('Add Exercise', href: new_exercise_path)
    end
  end

  context 'creation flow' do
    let(:page_path) { new_exercise_path }

    it 'allows the user to add a new exercise' do
      visit page_path

      fill_in 'Name', with: 'Squat'
      click_button 'Create Exercise'

      expect(page).to have_content('Exercise successfully created!')
      expect(Exercise.last.name).to eq('Squat')
    end

    it 'displays validation errors if the exercise cannot be saved' do
      visit page_path

      click_button 'Create Exercise'

      expect(page).to have_content("can't be blank")
      expect(Exercise.count).to eq(0)
    end
  end
end