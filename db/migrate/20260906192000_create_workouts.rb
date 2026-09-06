class CreateWorkouts < ActiveRecord::Migration[8.1]
  def change
    create_table :workouts do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
