class DailyStatistic < ApplicationRecord
  validates :date, presence: true
  validates :subject, presence: true
  validates :subject, uniqueness: { scope: :date }
end
