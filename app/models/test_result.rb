class TestResult < ApplicationRecord
  validates :student_name, presence: true
  validates :subject, presence: true
  validates :marks, presence: true
  validates :submitted_at, presence: true
end
