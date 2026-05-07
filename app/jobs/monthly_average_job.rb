class MonthlyAverageJob < ApplicationJob
  queue_as :default

  def perform
    MonthlyAverageCalculator.call
  end
end