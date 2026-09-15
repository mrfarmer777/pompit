class WorkoutEntry < ApplicationRecord
  belongs_to :workout

  validates :date, presence: true
end
