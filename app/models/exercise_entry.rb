class ExerciseEntry < ApplicationRecord
  belongs_to :workout_entry
  belongs_to :workout_exercise

  validates_presence_of :set_number
  validates_presence_of :reps
  validates_numericality_of :reps, :greater_than => 0, :only_integer => true
  validates_numericality_of :weight, :greater_than => 0, allow_nil: true

  validates :set_number, numericality: { less_than_or_equal_to: ->(entry) { entry.workout_exercise.set_count },
                                         greater_than: 0,
                                         only_integer: true}


end
