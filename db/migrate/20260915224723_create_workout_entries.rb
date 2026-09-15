class CreateWorkoutEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :workout_entries do |t|
      t.date :date, null: false
      t.integer :workout_id
      t.timestamps
    end
  end
end
