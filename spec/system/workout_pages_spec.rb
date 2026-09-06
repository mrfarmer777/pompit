require 'rails_helper'

RSpec.describe 'Workout Pages', type: :system do

  context 'index' do
    let(:page_path) { workouts_path }
    let!(:workout_1) { create :workout, name: 'Chest and Tricep' }
    let!(:workout_2) { create :workout, name: 'Back and Bicep' }

    it 'displays a list of links to each workout show page' do
      visit page_path

      expect(page).to have_link('Chest and Tricep', href: workout_path(workout_1))
      expect(page).to have_link('Back and Bicep', href: workout_path(workout_2))
    end

    it 'includes a link to add a new workout' do
      visit page_path

      expect(page).to have_link('Create Workout', href: new_workout_path)
    end

    it 'includes a button to delete existing workouts' do
      visit page_path

      rows = all('.workout-row')
      expect(rows.length).to eq(2)
      rows.each do |row|
        within(row) do
          expect(page).to have_button('Delete Workout')
        end
      end
    end

    it 'includes a link to edit existing workouts' do
      visit page_path

      rows = all('.workout-row')
      expect(rows.length).to eq(2)

      rows.each do |row|
        within(row) do
          expect(page).to have_link('Edit')
        end
      end
    end

    it 'allows workouts to be deleted' do
      visit page_path

      workout_row = find('.workout-row', match: :first)
      within(workout_row) do
        click_on 'Delete Workout'
      end

      expect(page).to have_content('Workout deleted!')
      expect{ workout_1.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'create' do
    let(:page_path) { new_workout_path }

    it 'allows the user to add a new workout' do
      visit page_path

      fill_in 'Name', with: 'Chest and Tricep'
      click_button 'Create Workout'

      expect(page).to have_content('Workout successfully created!')
      expect(Workout.last.name).to eq('Chest and Tricep')
    end

    it 'displays validation errors if the workout cannot be saved' do
      visit page_path

      click_button 'Create Workout'

      expect(page).to have_content("can't be blank")
      expect(Workout.count).to eq(0)
    end
  end

  context 'edit' do
    let(:workout) { create :workout, name: 'Back and Bicep' }
    let(:page_path) { edit_workout_path(workout, from: :show) }

    it 'allows the user to update a workout' do
      visit page_path

      fill_in 'Name', with: 'Chest and Tricep'
      click_button 'Update Workout'

      expect(page).to have_content('Workout successfully updated!')
      expect(current_path).to eq(workout_path(workout)), 'Should redirect to index page after update'
      expect(Workout.last.name).to eq('Chest and Tricep')
    end

    it 'displays validation errors if the workout cannot be updated' do
      visit page_path

      fill_in 'Name', with: ''
      click_button 'Update Workout'

      expect(page).to have_content("can't be blank")
      expect(Workout.last.name).to eq('Back and Bicep')
    end
  end

  context 'show' do
    let(:workout) { create :workout, name: 'Back and Bicep' }
    let(:page_path) { workout_path(workout) }

    it 'displays the workout details' do
      visit page_path

      expect(page).to have_content("Back and Bicep (#{workout.id})")
    end

    it 'allows workouts to be deleted' do
      visit page_path

      click_on 'Delete'

      expect(page).to have_content('Workout deleted!')
      expect{ workout.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'allows workouts to be edited' do
      visit page_path

      click_on 'Edit'
      fill_in 'Name', with: 'Chest and Tricep'

      click_on 'Update Workout'

      expect(page).to have_content('Workout successfully updated!')
      expect(workout.reload.name).to eq('Chest and Tricep')
      expect(current_path).to eq(workout_path(workout))
    end
  end
end