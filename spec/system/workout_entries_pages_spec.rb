require 'rails_helper'

RSpec.describe 'Workout Entries Pages', type: :system do

  # context 'index' do
  #   let(:page_path) { exercises_path }
  #   let!(:pull_up) { create :exercise, name: 'Pull Up' }
  #   let!(:push_up) { create :exercise, name: 'Push Up' }
  #
  #   it 'displays a list of links to exercise show pages' do
  #     visit page_path
  #
  #     expect(page).to have_link('Pull Up', href: exercise_path(pull_up))
  #     expect(page).to have_link('Push Up', href: exercise_path(push_up))
  #   end
  #
  #   it 'includes a link to add a new exercise' do
  #     visit page_path
  #
  #     expect(page).to have_link('Add Exercise', href: new_exercise_path)
  #   end
  #
  #   it 'includes a button to delete existing exercises' do
  #     visit page_path
  #
  #     rows = all('.exercise-row')
  #     expect(rows.length).to eq(2)
  #     rows.each do |row|
  #       within(row) do
  #         expect(page).to have_button('Delete Exercise')
  #       end
  #     end
  #   end
  #
  #   it 'includes a link to edit existing exercises' do
  #     visit page_path
  #
  #     rows = all('.exercise-row')
  #     expect(rows.length).to eq(2)
  #
  #     rows.each do |row|
  #       within(row) do
  #         expect(page).to have_link('Edit')
  #       end
  #     end
  #   end
  #
  #   it 'allows exercises to be deleted' do
  #     visit page_path
  #
  #     exercise_row = find('.exercise-row', match: :first)
  #     within(exercise_row) do
  #       click_on 'Delete Exercise'
  #     end
  #
  #     expect(page).to have_content('Exercise deleted!')
  #     expect{ pull_up.reload }.to raise_error(ActiveRecord::RecordNotFound)
  #   end
  # end

  context 'create' do
    let(:page_path) { new_workout_entry_path }
    let!(:workout) { create(:workout, name: 'Push Workout 1') }

    it 'allows the user to create a new workout entry' do
      visit page_path

      fill_in 'Date', with: Date.current

      select 'Push Workout 1', from: 'workout_entry[workout_id]'
      click_on 'Save Entry'

      expect(WorkoutEntry.count).to eq(1)
      expect(WorkoutEntry.last.workout).to eq(workout)
      expect(WorkoutEntry.last.date).to eq(Date.current)
    end

    it 'displays validation errors for a missing date' do
      visit page_path

      select 'Push Workout 1', from: 'workout_entry[workout_id]'
      click_on 'Save Entry'

      expect(page).to have_content("can't be blank") # missing date
    end
  end

  # context 'edit' do
  #   let(:exercise) { create :exercise, name: 'Push Up' }
  #   let(:page_path) { edit_exercise_path(exercise, from: :show) }
  #
  #   it 'allows the user to update an exercise' do
  #     visit page_path
  #
  #     fill_in 'Name', with: 'Squat'
  #     click_button 'Update Exercise'
  #
  #     expect(page).to have_content('Exercise successfully updated!')
  #     expect(current_path).to eq(exercise_path(exercise)), 'Should redirect to index page after update'
  #     expect(Exercise.last.name).to eq('Squat')
  #   end
  #
  #   it 'displays validation errors if the exercise cannot be updated' do
  #     visit page_path
  #
  #     fill_in 'Name', with: ''
  #     click_button 'Update Exercise'
  #
  #     expect(page).to have_content("can't be blank")
  #     expect(Exercise.last.name).to eq('Push Up')
  #   end
  # end

  context 'show' do
    let(:workout_entry) { create(:workout_entry) }
    let(:page_path) { workout_entry_path(workout_entry) }

    it 'displays the workout entry details' do
      visit page_path

      expect(page).to have_content("Date: #{workout_entry.date.to_s}")
      expect(page).to have_content(workout_entry.workout.name)
    end
  end
end