class Workout < ApplicationRecord
  validates :name, presence: true
  has_many :workout_exercises, index_errors: true
  has_many :exercises, through: :workout_exercises

  accepts_nested_attributes_for :workout_exercises, allow_destroy: true

end
