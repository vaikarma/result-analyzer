class MonthlyAverage < ApplicationRecord
  validates :month, presence: true
  validates :subject, presence: true
end
