class DailyStatisticsCalculator
  def self.call(date = Date.yesterday)
    aggregates = TestResult
      .where(submitted_at: date.beginning_of_day..date.end_of_day)
      .group(:subject)
      .pluck(
        :subject,
        Arel.sql("MIN(marks)"),
        Arel.sql("MAX(marks)"),
        Arel.sql("COUNT(*)")
      )

    aggregates.each do |subject, daily_low, daily_high, result_count|
      record = DailyStatistic.find_or_initialize_by(date: date, subject: subject)
      record.assign_attributes(
        daily_low: daily_low,
        daily_high: daily_high,
        result_count: result_count
      )
      record.save!
    end
  end
end
