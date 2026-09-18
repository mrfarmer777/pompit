class WorkoutEntry < ApplicationRecord
  belongs_to :workout
  has_many :exercise_entries, dependent: :destroy
  has_many :workout_exercises, through: :exercise_entries
  has_many :exercises, through: :workout_exercises

  validates :date, presence: true
end
