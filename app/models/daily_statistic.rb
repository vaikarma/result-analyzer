class DailyStatistic < ApplicationRecord
  validates :date, presence: true
  validates :subject, presence: true
end
