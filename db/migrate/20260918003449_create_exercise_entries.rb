class CreateExerciseEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :exercise_entries do |t|
      t.references :workout_exercise, null: false
      t.references :workout_entry, null: false
      t.integer :set_number
      t.decimal :weight
      t.integer :reps
      t.timestamps
    end
  end
end
