class MonthlyAverage < ApplicationRecord
  validates :month, presence: true
  validates :subject, presence: true
  validates :subject, uniqueness: { scope: :month }
end
