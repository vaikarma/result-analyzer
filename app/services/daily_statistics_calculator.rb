class DailyStatisticsCalculator
  def self.call(date = Date.yesterday)
    grouped_results = TestResult
      .where(submitted_at: date.beginning_of_day..date.end_of_day)
      .group_by(&:subject)

    grouped_results.each do |subject, results|
      DailyStatistic.create!(
        date: date,
        subject: subject,
        daily_low: results.map(&:marks).min,
        daily_high: results.map(&:marks).max,
        result_count: results.count
      )
    end
  end
end
