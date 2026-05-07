class DailyStatisticsJob < ApplicationJob
  queue_as :default

  def perform
    DailyStatisticsCalculator.call
  end
end