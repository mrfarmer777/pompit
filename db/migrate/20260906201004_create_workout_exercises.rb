class CreateWorkoutExercises < ActiveRecord::Migration[8.1]
  def change
    create_table :workout_exercises do |t|
      t.references :workout
      t.references :exercise
      t.integer :set_count
      t.timestamps
    end
  end
end
