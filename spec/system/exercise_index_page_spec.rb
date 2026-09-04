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

    it 'includes a button to delete existing exercises' do
      visit page_path

      rows = all('.exercise-row')
      expect(rows.length).to eq(2)
      rows.each do |row|
        within(row) do
          expect(page).to have_button('Delete Exercise')
        end
      end
    end

    it 'includes a link to edit existing exercises' do
      visit page_path

      rows = all('.exercise-row')
      expect(rows.length).to eq(2)

      rows.each do |row|
        within(row) do
          expect(page).to have_link('Edit')
        end
      end
    end

    it 'allows exercises to be deleted' do
      visit page_path

      exercise_row = find('.exercise-row', match: :first)
      within(exercise_row) do
        click_on 'Delete Exercise'
      end

      expect(page).to have_content('Exercise deleted!')
      expect{ pull_up.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'create' do
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

  context 'edit' do
    let(:exercise) { create :exercise, name: 'Push Up' }
    let(:page_path) { edit_exercise_path(exercise, from: :show) }

    it 'allows the user to update an exercise' do
      visit page_path

      fill_in 'Name', with: 'Squat'
      click_button 'Update Exercise'

      expect(page).to have_content('Exercise successfully updated!')
      expect(current_path).to eq(exercise_path(exercise)), 'Should redirect to index page after update'
      expect(Exercise.last.name).to eq('Squat')
    end

    it 'displays validation errors if the exercise cannot be updated' do
      visit page_path

      fill_in 'Name', with: ''
      click_button 'Update Exercise'

      expect(page).to have_content("can't be blank")
      expect(Exercise.last.name).to eq('Push Up')
    end
  end

  context 'show' do
    let(:exercise) { create :exercise, name: 'Pull Up' }
    let(:page_path) { exercise_path(exercise) }

    it 'displays the exercise details' do
      visit page_path

      expect(page).to have_content("Pull Up (#{exercise.id})")
    end

    it 'allows exercises to be deleted' do
      visit page_path

      click_on 'Delete'

      expect(page).to have_content('Exercise deleted!')
      expect{ exercise.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'allows exercises to be edited' do
      visit page_path

      click_on 'Edit'
      fill_in 'Name', with: 'Squat'

      click_on 'Update Exercise'

      expect(page).to have_content('Exercise successfully updated!')
      expect(exercise.reload.name).to eq('Squat')
      expect(current_path).to eq(exercise_path(exercise))
    end
  end
end