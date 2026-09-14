class WorkoutExercise < ApplicationRecord
  belongs_to :workout
  belongs_to :exercise

  validates :set_count, numericality: { only_integer: true, greater_than: 0 }
end
