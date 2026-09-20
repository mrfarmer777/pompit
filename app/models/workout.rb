class Workout < ApplicationRecord
  validates :name, presence: true
  has_many :workout_exercises, index_errors: true
  has_many :exercises, through: :workout_exercises
  has_many :entries, class_name: 'WorkoutEntry'

  accepts_nested_attributes_for :workout_exercises, allow_destroy: true

end
