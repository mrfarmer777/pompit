require 'rails_helper'

RSpec.describe 'Workout Entries Pages', type: :system do

  context 'index' do
    let(:page_path) { workout_entries_path(workout) }
    let(:workout) { create :workout }
    let!(:entry_1) { create :workout_entry, workout:, date: Date.current - 1.day }
    let!(:entry_2) { create :workout_entry, workout:, date: Date.current - 2.days }

    it 'displays a list of links to workout entry show pages' do
      visit page_path

      expect(page).to have_link(entry_1.date.to_s, href: workout_entry_path(workout_id: workout.id, id: entry_1.id))
      expect(page).to have_link(entry_2.date.to_s, href: workout_entry_path(workout_id: workout.id, id: entry_2.id))
    end


    it 'includes a link to edit existing exercises' do
      visit page_path

      rows = all('.workout-entry-row')
      expect(rows.length).to eq(2)
      entries = [entry_1, entry_2]

      rows.each_with_index do |row, index|
        within(row) do
          expect(page).to have_link('Edit', href: edit_workout_entry_path(workout, entries[index], from: 'index'))
        end
      end
    end

    it 'allows exercises to be deleted' do
      visit page_path

      exercise_row = find('.workout-entry-row', match: :first)
      within(exercise_row) do
        click_on 'Delete Entry'
      end

      expect(page).to have_content('Workout Entry deleted!')
      expect{ entry_1.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'create'   do
    let(:page_path) { new_workout_entry_path(workout) }
    let!(:workout) { create(:workout, :with_exercises, exercise_count: 1, name: 'Push Workout 1') }

    it 'allows the user to create a new workout entry' do
      visit page_path

      fill_in 'Date', with: Date.current

      click_on 'Save Entry'

      expect(WorkoutEntry.count).to eq(1)
      expect(WorkoutEntry.last.workout).to eq(workout)
      expect(WorkoutEntry.last.date).to eq(Date.current)
    end

    it 'displays validation errors for a missing date' do
      visit page_path

      click_on 'Save Entry'

      expect(page).to have_content("can't be blank") # missing date
    end

    it 'includes exercise entry fields for each workout exercise set' do
      visit page_path

      expect(page).to have_selector('.exercise-entry-row', count: 3) # 1 exercises x 3 sets each = 3 rows
    end

    it 'allows user to create exercises entries at creation time' do
      visit page_path

      fill_in 'Date', with: Date.current

      reps_input = find('[name="workout_entry[exercise_entries_attributes][1][reps]"]')
      weight_input = find('[name="workout_entry[exercise_entries_attributes][1][weight]"]')

      reps_input.set('1')
      weight_input.set('20')

      click_on 'Save Entry'

      expect(WorkoutEntry.count).to eq(1)
      expect(WorkoutEntry.last.exercise_entries.size).to eq(1)
    end
  end

  context 'edit' do
    let(:workout) { create :workout }
    let(:workout_entry) { create :workout_entry, workout: }
    let(:page_path) { edit_workout_entry_path(workout_entry.workout, workout_entry, from: :show) }

    it 'allows the user to update a workout entry' do
      visit page_path

      fill_in 'Date', with: Date.current - 3.days
      click_button 'Update Entry'

      expect(page).to have_content('Workout Entry successfully updated!')
      expect(current_path).to eq(workout_entry_path(workout, workout_entry)), 'Should redirect to show page after update'
      expect(WorkoutEntry.last.date).to eq(Date.current - 3.days)
    end

    it 'displays validation errors' do
      visit page_path

      fill_in 'Date', with: ''
      click_button 'Update Entry'

      expect(page).to have_content("can't be blank")
    end
  end

  context 'show' do
    let(:workout) { create :workout }
    let(:workout_entry) { create(:workout_entry, workout:) }
    let(:page_path) { workout_entry_path(workout, workout_entry) }

    it 'displays the workout entry details' do
      visit page_path

      expect(page).to have_content("Date: #{workout_entry.date.to_s}")
      expect(page).to have_content(workout_entry.workout.name)
    end
  end
end