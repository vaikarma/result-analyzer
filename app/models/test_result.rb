class TestResult < ApplicationRecord
  validates :student_name, presence: true
  validates :subject, presence: true
  validates :marks, presence: true
  validates :marks, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :submitted_at, presence: true
end
