require "rails_helper"

RSpec.describe MonthlyAverageCalculator do
  describe ".call" do
    it "runs only on the Monday of the week containing the third Wednesday" do
      # May 2026: third Wednesday is 2026-05-20; that week's Monday is 2026-05-18
      create(:daily_statistic, subject: "Math", date: Date.new(2026, 5, 17), result_count: 250)

      travel_to Time.zone.local(2026, 5, 18, 18, 5, 0) do
        expect { described_class.call }.to change(MonthlyAverage, :count).by(1)
      end

      travel_to Time.zone.local(2026, 5, 19, 18, 5, 0) do
        expect { described_class.call }.not_to change(MonthlyAverage, :count)
      end
    end

    it "creates a monthly average for each subject present in daily statistics" do
      create(:daily_statistic, subject: "Math", date: Date.new(2026, 5, 17), daily_low: 10, daily_high: 20, result_count: 250)
      create(:daily_statistic, subject: "Science", date: Date.new(2026, 5, 17), daily_low: 30, daily_high: 40, result_count: 250)

      travel_to Time.zone.local(2026, 5, 18, 18, 5, 0) do
        expect { described_class.call }.to change(MonthlyAverage, :count).by(2)
      end

      expect(MonthlyAverage.pluck(:subject)).to contain_exactly("Math", "Science")
    end

    it "is idempotent for the same month/subject" do
      create(:daily_statistic, subject: "Math", date: Date.new(2026, 5, 17), daily_low: 10, daily_high: 20, result_count: 250)

      travel_to Time.zone.local(2026, 5, 18, 18, 5, 0) do
        expect {
          described_class.call
          described_class.call
        }.to change(MonthlyAverage, :count).by(1)
      end
    end
  end

  describe ".calculate_for_subject" do
    before do
      5.times do |i|
        create(
          :daily_statistic,
          subject: "Math",
          date: Date.today - i,
          daily_low: 40,
          daily_high: 90,
          result_count: 50
        )
      end
    end

    it "creates monthly average" do
      expect {
        described_class.calculate_for_subject("Math")
      }.to change(MonthlyAverage, :count).by(1)

      average = MonthlyAverage.last

      expect(average.average_daily_low).to eq(40.0)
      expect(average.average_daily_high).to eq(90.0)
      expect(average.total_result_count).to eq(250)
    end

    it "expands beyond 5 days when the first 5 days have < 200 total results" do
      DailyStatistic.delete_all

      # 5 most recent days total 150 (<200)
      5.times do |i|
        create(
          :daily_statistic,
          subject: "Math",
          date: Date.today - i,
          daily_low: 0,
          daily_high: 100,
          result_count: 30
        )
      end

      # add 2 more older days to bring total to 210
      create(:daily_statistic, subject: "Math", date: Date.today - 10, daily_low: 100, daily_high: 0, result_count: 30)
      create(:daily_statistic, subject: "Math", date: Date.today - 11, daily_low: 100, daily_high: 0, result_count: 30)

      described_class.calculate_for_subject("Math")

      average = MonthlyAverage.last
      expect(average.total_result_count).to eq(210)

      # Selected 7 days: five (0,100) and two (100,0)
      expect(average.average_daily_low).to eq((0 * 5 + 100 * 2).to_f / 7)
      expect(average.average_daily_high).to eq((100 * 5 + 0 * 2).to_f / 7)
    end

    it "does not create a monthly average when there are no daily statistics" do
      DailyStatistic.delete_all

      expect {
        described_class.calculate_for_subject("Math")
      }.not_to change(MonthlyAverage, :count)
    end
  end
end
