class MonthlyAverageCalculator
  MINIMUM_RESULTS = 200

  def self.call
    return unless run_day?

    subjects = DailyStatistic.distinct.pluck(:subject)

    subjects.each do |subject|
      calculate_for_subject(subject)
    end
  end

  def self.calculate_for_subject(subject)
    stats = DailyStatistic
              .where(subject: subject)
              .order(date: :desc)

    selected_stats = []
    total_count = 0

    stats.each do |stat|
      selected_stats << stat
      total_count += stat.result_count

      break if selected_stats.size >= 5 && total_count >= MINIMUM_RESULTS
    end

    return if selected_stats.empty?

    month = Date.today.strftime("%Y-%m")
    record = MonthlyAverage.find_or_initialize_by(month: month, subject: subject)
    record.assign_attributes(
      average_daily_low: selected_stats.sum(&:daily_low).to_f / selected_stats.size,
      average_daily_high: selected_stats.sum(&:daily_high).to_f / selected_stats.size,
      total_result_count: total_count
    )
    record.save!
  end

  def self.run_day?
    today = Date.today

    third_wednesday =
      (1..31)
        .map { |day| Date.new(today.year, today.month, day) rescue nil }
        .compact
        .select(&:wednesday?)[2]

    monday_of_week = third_wednesday.beginning_of_week

    today == monday_of_week
  end
end
